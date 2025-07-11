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
const clientiRoutes = require("./routes/clienti")  // Importa le rotte dei clienti;
const fornitoriRoutes = require("./routes/fornitori"); // Importe le rotte dei fornitori
const ricambiRoutes = require("./routes/ricambi");
const movimentiRoutes = require("./routes/movimentiroutes"); // Importa le rotte dei movimenti
const causaliRoutes = require("./routes/causaliroutes"); // Importa le rotte delle causali
const authRoutes = require("./routes/authRoutes");
const userRoutes = require("./routes/userRoutes"); // Importa le rotte degli utenti
const dibaRoutes = require("./routes/dibaroutes");
const ordiniRoutes = require("./routes/ordini.js"); // Importa le rotte per gli ordini
const errorHandler = require("./middleware/errorHandler");
const pool = require("./db/db"); // Importa il pool di connessioni al DB

const app = express();

// HTTP security headers
app.use(helmet());

// Rate limiter di base: 100 richieste / 15 minuti per IP
const apiLimiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 100, standardHeaders: true, legacyHeaders: false });
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

logger.info("Montaggio fornitoriRoutes");
app.use("/api/fornitori", authenticateToken, fornitoriRoutes); // tutte le rotte per i ricambi iniziano con /api/fornitori


logger.info("Montaggio clientiRoutes");
app.use("/api/clienti", authenticateToken, clientiRoutes); // tutte le rotte per i ricambi iniziano con /api/clienti

logger.info("Montaggio ricambiRoutes");
app.use("/api/ricambi", authenticateToken, ricambiRoutes); // tutte le rotte per i ricambi iniziano con /api/ricambi

logger.info("Montaggio movimentiRoutes");
app.use("/api/movimenti", authenticateToken, movimentiRoutes); // tutte le rotte per i movimenti iniziano con /api/movimenti

logger.info("Montaggio causaliRoutes");
app.use("/api/causali", authenticateToken, causaliRoutes); // tutte le rotte per le causali iniziano con /api/causali

logger.info("Montaggio userRoutes");
app.use("/api/users", authenticateToken, userRoutes); // Rotte per gli utenti

logger.info("Montaggio dibaRoues");
app.use("/api/diba", authenticateToken, dibaRoutes); // tutte le rotte per le diba iniziano con /api/diba);

logger.info("Montaggio ordiniRoutes");
app.use("/api/ordini", authenticateToken, ordiniRoutes); // tutte le rotte per le diba iniziano con /api/diba);

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
