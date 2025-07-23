//================================
// File: db.js
// Script che crea la connessione al database MySql in modo sicuro
// @author: "villari.andrea@libero.it"
// @version: "1.1.0 2025-07-13"
//===============================================
const mysql = require("mysql2/promise");

// Carica variabili d'ambiente se non già caricate (fallback)
if (!process.env.DB_HOST) {
  try {
    require("dotenv-safe").config();
  } catch (err) {
    require("dotenv").config();
    console.warn(
      "⚠️  dotenv-safe non disponibile o errore, fallback a dotenv:",
      err.message
    );
  }
}

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "magazzino",
  waitForConnections: true,
  connectionLimit: process.env.DB_CONNECTION_LIMIT
    ? parseInt(process.env.DB_CONNECTION_LIMIT)
    : 10,
  queueLimit: 0,
  // Le query parametrizzate sono sempre consigliate per sicurezza (SQL injection)
  // Per prepared statements ripetitivi, usare connection.prepare() dove serve
});


module.exports = pool;
