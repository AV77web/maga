//============================================
//File: ordinicontrollers.js
//Script che crea i controller per le operazioni 
//sugli ordini
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2025-07-08"
//==============================================

const db = require("../db/db");
const logger = require("../utils/logger");

(async () => {
  try {
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    logger.info({ msg: "Connessione DB ordini OK", result: rows[0] });
  } catch (err) {
    logger.error({ msg: "Errore connessione DB ordini", err: err.message });
  }
})();

// GET tutti gli ordini, con gestione dei filtri
exports.getOrdini = async (req, res, next) => {
  try {
    // Estrai i possibili filtri da req.query
    const { num_ordine, fornitore_id, stato, data_da, data_a } = req.query;

    // Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const params = [
      num_ordine || null,
      fornitore_id || null,
      stato || null,
      data_da || null,
      data_a || null
    ];

    logger.debug({ num_ordine, fornitore_id, stato, data_da, data_a }, "Call FetchOrdini");

    // Assumendo che esista una SP 'FetchOrdini' che accetta questi filtri
    const [results] = await db.query("CALL FetchOrdini(?, ?, ?, ?, ?)", params);

    const rows = results[0];

    logger.debug({ rows: rows.length }, "Rows returned FetchOrdini");
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero degli ordini:", error.message);
    next(error);
  }
};

// GET righe di un ordine specifico
exports.getOrdineRighe = async (req, res, next) => {
  try {
    const { ordineId } = req.params;
    if (!ordineId) {
      return res.status(400).json({ success: false, message: "ID Ordine mancante." });
    }

    // Assumendo una SP 'FetchOrdineRighe' che accetta l'ID dell'ordine
    const [results] = await db.query("CALL FetchOrdineRighe(?)", [ordineId]);
    const rows = results[0];
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error(`Errore nel recupero delle righe per l'ordine ID ${req.params.ordineId}:`, error.message);
    next(error);
  }
};

// POST: crea un nuovo ordine
exports.insertOrdine = async (req, res, next) => {
  try {
    // Crea una copia del body per poter convertire i tipi senza modificare l'originale
    const dataToValidate = { ...req.body };
    if (dataToValidate.fornitore_id) {
        dataToValidate.fornitore_id = Number(dataToValidate.fornitore_id);
    }

    const { num_ordine, data_ordine, fornitore_id, stato, note } = dataToValidate;
    
    // Assumendo una SP 'InsertOrdine'
    const [results] = await db.query("CALL InsertOrdini(?, ?, ?, ?, ?)", [
      num_ordine,
      data_ordine,
      fornitore_id,
      stato,
      note || null,
    ]);

    const newId = results[0][0].id_ordine; // Assumendo che la SP restituisca l'ID

    res.status(201).json({ success: true, id_ordine: newId, message: "Ordine creato con successo." });
  } catch (error) {
    console.error("Errore nell'inserimento dell'ordine:", error.message);
    next(error);
  }
};

// PUT: aggiorna un ordine esistente
exports.updateOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;

    const dataToValidate = { ...req.body };
    if (dataToValidate.fornitore_id) {
        dataToValidate.fornitore_id = Number(dataToValidate.fornitore_id);
    }

    const { num_ordine, data_ordine, fornitore_id, stato, note } = dataToValidate;

    // Assumendo una SP 'UpdateOrdine'
    const [result] = await db.query("CALL UpdateOrdine(?, ?, ?, ?, ?, ?)", [ id_ordine, num_ordine, data_ordine, fornitore_id, stato, note || null]);
    
    if (result.affectedRows === 0) {
        return res.status(404).json({ success: false, message: "Ordine non trovato per l'aggiornamento." });
    }

    res.json({ success: true, message: "Ordine aggiornato con successo." });
  } catch (error) {
    console.error(`Errore nell'aggiornamento dell'ordine con ID ${req.params.id_ordine}:`, error.message);
    next(error);
  }
};

// DELETE: elimina un ordine
exports.deleteOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;

    // Assumendo una SP 'DeleteOrdine'
    const [result] = await db.query("CALL DeleteOrdine(?)", [id_ordine]);

    if (result.affectedRows === 0) {
        return res.status(404).json({ success: false, message: "Ordine non trovato per l'eliminazione." });
    }

    res.json({ success: true, message: "Ordine eliminato con successo." });
  } catch (error) {
    console.error(`Errore nell'eliminazione dell'ordine con ID ${req.params.id_ordine}:`, error.message);
    next(error);
  }
};