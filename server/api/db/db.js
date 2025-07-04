//================================
//File:db.js
//Script che crea la connessione al database MySql
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//===============================================
const mysql = require("mysql2/promise");

const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  password: "",
  database: "magazzino",
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
});

module.exports = pool;
