//===================================
//File: index.js
//Script per avviare il server Express
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//===================================

let dotenvLoaded = false;
try {
  const dotenvSafe = require("dotenv-safe");
  dotenvSafe.config({
    allowEmptyValues: true, // in dev permetti valori vuoti
  });
  dotenvLoaded = true;
} catch (err) {
  // Se .env.example non esiste o altre issues, ripiega su dotenv classico
  require("dotenv").config();
  console.warn("⚠️  dotenv-safe non disponibile o errore, fallback a dotenv:", err.message);
}

const logger = require("./utils/logger");

const express = require("express");
const cors = require("cors");
const helmet = require("helmet");
const rateLimit = require("express-rate-limit");
// Legacy route files rimossi – ora sostituiti dai moduli v1
const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes"); // Importa le rotte degli utenti
// const dibaRoutes = require("./routes/dibaroutes"); // deprecato
// const ordiniRoutes = require("./routes/ordini.js"); // deprecato

const partsRoutes = require("./modules/parts/parts.routes");
const ordersRoutesV1 = require("./modules/orders/orders.routes");
const counterpartiesRoutes = require("./modules/counterparties/counterparties.routes");
const movementsRoutesV1 = require("./modules/movements/movements.routes");
const causesRoutesV1 = require("./modules/causes/causes.routes");
const bomRoutesV1 = require("./modules/bom/bom.routes");
const errorHandler = require("./middleware/errorHandler");
const orderLinesModule = require('./modules/orderlines/orderlines.routes');
const pool = require("./db/db"); // Importa il pool di connessioni al DB


const app = express();

// CORS – deve essere registrato PRIMA di helmet per gestire la preflight correttamente
app.use(
  cors({
    origin: process.env.FRONTEND_ORIGIN || "http://localhost:5173",
    methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
    credentials: true,
  })
);

// cors middleware gestisce già le richieste OPTIONS (preflight)

// HTTP security headers
app.use(helmet());

// Rate limiter di base: 100 richieste / 15 minuti per IP
const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minuti
  max: 1000, // limite più alto per SPA
  standardHeaders: true,
  legacyHeaders: false,
  skip: (req) => req.method === "GET" && req.originalUrl.startsWith("/api/v1/users"),
});
app.use(apiLimiter);

//Middleware di autenticazione JWT
const authenticateToken = require("./middleware/authenticateToken");
logger.info("Caricato middleware authenticateToken");

//Middleware per analizzare i corpi delle richieste json
app.use(express.json());

// Middleware per analizzare i corpi delle richieste codificati in URL (facoltativo, ma consigliabile)
app.use(express.urlencoded({ extended: true }));

// 🔍 TEST connessione DB
const checkDbConnection = async () => {
  try {
    const [rows] = await pool.query("SELECT 1 + 1 AS result");
    logger.info({ msg: "DB connection OK", result: rows[0] });
  } catch (err) {
    logger.error({ msg: "DB connection error", err: err.message });
  }
};
checkDbConnection();

// Middleware per loggare ogni richiesta in arrivo
//app.use((req, res, next) => {
//    console.log(`Incoming Request: ${req.method} ${req.originalUrl}`);
//    next(); // Passa al prossimo middleware/rotta
//});

// TEST: Rotta semplice per verificare se Express gestisce le rotte
//app.get('/test', (req, res) => {
//    console.log("🟢 index.js: Raggiunta rotta /test");
//    res.send('Test route reached!');
//});
// Rotte pubbliche (non richiedono autenticazione)
logger.info("Montaggio authRoutes");
app.use("/api/auth", authRoutes);

// Applicazione del middleware authenticateToken alle rotte protette

// ⚠️ Deprecate legacy /api/* routes – commentate per rimozione definitiva.
logger.warn("Legacy /api/* routes disabilitate. Aggiornare i client a /api/v1/*");
// app.use("/api/fornitori", authenticateToken, fornitoriRoutes);
// app.use("/api/clienti", authenticateToken, clientiRoutes);
// app.use("/api/ricambi", authenticateToken, ricambiRoutes);
// app.use("/api/movimenti", authenticateToken, movimentiRoutes);
// app.use("/api/causali", authenticateToken, causaliRoutes);
// app.use("/api/users", authenticateToken, userRoutes);
// app.use("/api/diba", authenticateToken, dibaRoutes);
// app.use("/api/ordini", authenticateToken, ordiniRoutes);

// Nuovo endpoint v1
//app.use("/api/v1/orders", authenticateToken, ordersRoutesV1);
app.use('/api/v1/orders', require('./modules/orders/orders.routes'));
app.use('/api/v1/orderlines', authenticateToken, orderLinesModule);

// 🔵 Nuove rotte versione v1
app.use("/api/v1/parts", authenticateToken, partsRoutes);
// Rotte legacy rimosse – usare solo /api/v1/counterparties
app.use("/api/v1/movements", authenticateToken, movementsRoutesV1);
app.use("/api/v1/causes", authenticateToken, causesRoutesV1);
app.use("/api/v1/bom", authenticateToken, bomRoutesV1);
// 🔴 Nuova rotta unificata controparti (clienti + fornitori)
app.use("/api/v1/counterparties", authenticateToken, counterpartiesRoutes);
app.use("/api/v1/users", authenticateToken, userRoutes);



// Middleware di gesrtione degli errori centralizzato
app.use(errorHandler);

const PORT = process.env.PORT || 3001;

app.listen(PORT, (err) => {
  if (err) {
    logger.error({ msg: `Errore in ascolto sulla porta ${PORT}`, err: err.message });
  } else {
    logger.info(`Server avviato su http://localhost:${PORT}`);
    logger.info(`JWT_SECRET ${process.env.JWT_SECRET ? "presente" : "NON definito"}`);
  }
});
