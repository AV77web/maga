//===================================
//File: index.js
//Script per avviare il server Express
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//===================================

require("dotenv").config(); // carica le variabili d'ambiente
const express = require("express");
const cors = require("cors");
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
app.use(
  cors({
    origin: "http://localhost:5173", //
    methods: ["GET", "POST", "PUT", "DELETE"],
    credentials: true, //
  })
);
//Middleware di autenticazione JWT
const authenticateToken = require("./middleware/authenticateToken");
console.log("🟢 index.js: Caricamento di authenticateToke");
console.log("ciao");
//Middleware per analizzare i corpi delle richieste json
app.use(express.json());

// Middleware per analizzare i corpi delle richieste codificati in URL (facoltativo, ma consigliabile)
app.use(express.urlencoded({ extended: true }));

// 🔍 TEST connessione DB
const checkDbConnection = async () => {
  try {
    // @ts-ignore
    const [rows] = await pool.query("SELECT 1 + 1 AS result"); // Usa 'pool' invece di 'db'
    console.log("✅ Connessione al database OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB:", err.message);
  }
};
checkDbConnection(); // Esegui il test della connessione all'avvio

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
console.log(
  "🟠 index.js: Caricamento authRoutes:",
  typeof authRoutes,
  authRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express"
);
app.use("/api/auth", authRoutes);

// Applicazione del middleware authenticateToken alle rotte protette

console.log(
  "🟠 index.js: Caricamento fornitoriRoutes:",
  typeof fornitoriRoutes,
  fornitoriRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(fornitoriRoutes)
);
app.use("/api/fornitori", authenticateToken, fornitoriRoutes); // tutte le rotte per i ricambi iniziano con /api/fornitori


console.log(
  "🟠 index.js: Caricamento clientiRoutes:",
  typeof clientiRoutes,
  clientiRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(clientiRoutes)
);
app.use("/api/clienti", authenticateToken, clientiRoutes); // tutte le rotte per i ricambi iniziano con /api/clienti

console.log(
  "🟠 index.js: Caricamento ricambiRoutes:",
  typeof ricambiRoutes,
  ricambiRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(ricambiRoutes)
);
app.use("/api/ricambi", authenticateToken, ricambiRoutes); // tutte le rotte per i ricambi iniziano con /api/ricambi

console.log(
  "🟠 index.js: Caricamento movimentiRoutes:",
  typeof movimentiRoutes,
  movimentiRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(movimentiRoutes)
);
app.use("/api/movimenti", authenticateToken, movimentiRoutes); // tutte le rotte per i movimenti iniziano con /api/movimenti

console.log(
  "🟠 index.js: Caricamento causaliRoutes:",
  typeof causaliRoutes,
  causaliRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(causaliRoutes)
);
app.use("/api/causali", authenticateToken, causaliRoutes); // tutte le rotte per le causali iniziano con /api/causali

console.log(
  "🟠 index.js: Caricamento userRoutes:",
  typeof userRoutes,
  userRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express"
);
app.use("/api/users", authenticateToken, userRoutes); // Rotte per gli utenti

console.log(
  "🟠 index.js: Caricamento dibaRoues",
  typeof dibaRoutes,
  dibaRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(dibaRoutes)
);
app.use("/api/diba", authenticateToken, dibaRoutes); // tutte le rotte per le diba iniziano con /api/diba);

console.log(
  "🟠 index.js: Caricamento ordiniRoutes",
  typeof ordiniRoutes,
  ordiniRoutes instanceof require("express").Router
    ? "è un Router Express"
    : "NON è un Router Express",
  Object.keys(ordiniRoutes)
);
app.use("/api/ordini", authenticateToken, ordiniRoutes); // tutte le rotte per le diba iniziano con /api/diba);

// Middleware di gesrtione degli errori centralizzato
app.use(errorHandler);

const PORT = process.env.PORT || 3001; // Usa la porta da .env se definita, altrimenti 3001

app.listen(PORT, (err) => {
  if (err) {
    console.error(
      `❌ ERRORE durante l'avvio del server sulla porta ${PORT}:`,
      err.message
    );
  } else {
    console.log(`🚀 Server avviato su http://localhost:${PORT}`);
    console.log(
      `🔑 JWT_SECRET caricato: ${
        process.env.JWT_SECRET
          ? "Sì, presente."
          : 'No, ATTENZIONE! Verificare file .env e require("dotenv").config()'
      }`
    );
  }
});
