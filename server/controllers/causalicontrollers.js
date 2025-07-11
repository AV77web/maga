//==========================================
//File: // controllers//causalicontrollers.js
//Script che crea i controller per le operazioni sulle causali
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const db = require("../db/db");
const logger = require("../utils/logger");

(async () => {
  try {
    // Test query per verificare la connessione
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    logger.info({ msg: "Connessione DB causali OK", result: rows[0] });
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per causali:", err);
  }
})();

// Remove validateCausaleInput function and validation usage

// exports.getCausali = causaliCrudHandlers.getAll; // Replaced by custom fetchCausali
exports.getCausali = async (req, res, next) => {
  try {
    const { codice, description, tipo } = req.query;

    // Chiama la stored procedure con i parametri, passando null se non presenti
    const [rows] = await db.query(
      'CALL FetchCausali(?, ?, ?)',
      [
        codice || null,
        description || null,
        tipo || null
      ]
    );
    res.json({ success: true, data: rows[0] }); // Le stored procedure restituiscono un array di array, il primo elemento contiene i risultati
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// exports.insertCausale = causaliCrudHandlers.create; // Replaced by custom insertCausale
exports.insertCausale = async (req, res, next) => {
  const { codice, description, tipo, attiva } = req.body;

  // Assicurati che 'attiva' sia un booleano o che sia true di default se non fornito
  const p_attiva = attiva === undefined ? true : !!attiva;

  try {
    const [results] = await db.query(
      'CALL InsertCausali(?, ?, ?, ?)',
      [codice, description, tipo, p_attiva]
    );

    // La stored procedure restituisce LAST_INSERT_ID() come 'id'
    const newId = results[0][0].id;

    res.status(201).json({ success: true, id: newId, message: 'Causale creata con successo.' });
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// exports.getCausaleById = causaliCrudHandlers.getById; // Rimosso come da richiesta
// exports.updateCausale = causaliCrudHandlers.update; // Rimosso come da richiesta
// exports.deleteCausale = causaliCrudHandlers.delete; // Rimosso come da richiesta