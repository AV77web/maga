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
    const {
      name,
      supplier /* altri filtri eventualmente */,
      page = 1,
      page_size = 10,
      order_by = "name",
      order_dir = "ASC",
    } = req.query;

    //==================================================
    // Prepara i parametri per la stored procedure, effettuando conversioni sicure.
    const p_name = name || null;
    const p_supplier = supplier || null;

    // Converte i parametri numerici assicurandosi di avere interi positivi.
    const p_page = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size = Math.max(parseInt(page_size, 10) || 10, 1);

    // Normalizza l'ordinamento per prevenire SQL-Injection (il nome colonna verrà validato nel DB)
    const p_order_by = order_by;
    const p_order_dir = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      { p_name, p_supplier, p_page, p_page_size, p_order_by, p_order_dir },
      "Call FetchArticoli"
    );

    // Chiama la stored procedure con i parametri attesi
    const [resultSets] = await db.query("CALL FetchArticoli(?,?,?,?,?,?)", [
      p_name,
      p_supplier,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    /*
      FetchArticoli restituisce due result-set:
      1. Un array con una sola riga, colonna "data" che contiene una stringa JSON con i record.
      2. Un array con una sola riga, colonna "meta" con informazioni di paginazione in JSON.
    */

    if (!Array.isArray(resultSets) || resultSets.length < 2) {
      throw new Error("Formato risposta SP FetchArticoli non riconosciuto");
    }

    const rawRows = resultSets[0][0]?.data ?? [];
    const rawMeta = resultSets[1][0]?.meta ?? {};

    const rows = typeof rawRows === "string" ? JSON.parse(rawRows) : rawRows;
    const meta = typeof rawMeta === "string" ? JSON.parse(rawMeta) : rawMeta;

    logger.debug({ rows: rows.length, meta }, "Rows returned FetchArticoli");

    // Restituisci i dati in un formato compatibile con il client (result + meta)
    return res.json({ success: true, result: { rows, meta } });
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
