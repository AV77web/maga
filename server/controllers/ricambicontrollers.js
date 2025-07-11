//==========================================
//File: // controllers//ricambiController.js
//Script che crea i controller per le operazioni sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//==========================================
const { createCrudHandlers } = require("./crudHandlers"); // Assumendo che il file sia in utils
const db = require("../db/db");
const logger = require("../utils/logger");

(async () => {
  try {
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    logger.info({ msg: "Connessione DB ricambi OK", result: rows[0] });
  } catch (err) {
    console.error("❌ ERRORE connessione al DB:", err.message);
  }
})();

// Nota: Nonostante l'esistenza di crudHandlers.js, le operazioni sui ricambi
// utilizzano Stored Procedure per incapsulare logiche di business specifiche
// (es. gestione delle giacenze o validazioni complesse lato DB),
// rendendo necessarie implementazioni custom per queste funzioni.
// const ricambiCrudHandlers = createCrudHandlers('articoli', { validateInput: validateRicambioInput }); // Rimosso perché non utilizzato per le operazioni principali

// GET tutti i ricambi, con gestione dei filtri
exports.getRicambi = async (req, res) => {
  try {
    // Estrai i possibili filtri da req.query
    // Questi nomi devono corrispondere a quelli usati in ricambiFilterFields nel frontend
    const { name, description, supplier /*, altri filtri se ne hai */ } =
      req.query;

    //==================================================
    //Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const p_name = name || null;
    const p_description = description || null;
    const p_supplier = supplier || null;

    logger.debug({ p_name, p_description, p_supplier }, "Call FetchArticoli");

    // Chiama la stored procedure con i parametri
    const [results] = await db.query("CALL FetchArticoli(?,?,?)", [
      p_name,
      p_description,
      p_supplier,
    ]);

    // La libreria mysql2 restituisce un array di array per le stored procedures,
    // il primo elemento contiene le righe di dati.
    const rows = results[0];

    logger.debug({ rows: rows.length }, "Rows returned FetchArticoli");
    res.json({ success: true, result: rows });
  } catch (error) {
    console.error("Errore nel recupero dei ricambi:", error.message);
    res.status(500).json({ success: false, error: error.message });
  }
};

// Custom insertRicambio to use stored procedure InsertArticolo
exports.insertRicambio = async (req, res, next) => {
  try {
    const { name, description, quantita, min, max, supplier, um, prezzo } =
      req.body;

    const [results] = await db.query("CALL InsertArticolo(?,?,?,?,?,?,?,?)", [
      name,
      description,
      quantita,
      min,
      max,
      supplier,
      um,
      prezzo,
    ]);

    const newId = results[0][0].id; // Assuming the procedure returns LAST_INSERT_ID() as 'id'

    res.status(201).json({
      success: true,
      id: newId,
      message: "Ricambio creato con successo.",
    });
  } catch (error) {
    console.error("Errore nell'inserimento del ricambio:", error.message);
    next(error);
  }
};

// Custom updateRicambio to use stored procedure UpdateArticolo
exports.updateRicambio = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, description, quantita, min, max, supplier, um, prezzo } =
      req.body;

    await db.query("CALL UpdateArticolo(?,?,?,?,?,?,?,?)", [
      id,
      name,
      description,
      quantita,
      min,
      max,
      supplier,
      um,
      prezzo,
    ]);

    res.json({ success: true, message: "Ricambio aggiornato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'aggiornamento del ricambio con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};

// Custom deleteRicambio to use stored procedure DeleteArticoli
exports.deleteRicambio = async (req, res, next) => {
  try {
    const { id } = req.params;

    await db.query("CALL DeleteArticoli(?)", [id]);

    res.json({ success: true, message: "Ricambio eliminato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'eliminazione del ricambio con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};
