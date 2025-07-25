//==========================================
//File: // controllers/fornitoricontrollers.js
//Script che crea i controller per le operazioni sui fornitori
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-08"
//==========================================
const db = require("../db/db");
const logger = require("../utils/logger");

// GET tutti i fornitori, con gestione dei filtri
exports.getFornitori = async (req, res, next) => {
  try {
    // Estrai i possibili filtri da req.query
    const { codice, rag_soc, partita_iva, cf, citta, contatto } = req.query;

    // Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const p_codice = codice || null;
    const p_ragione_sociale = rag_soc || null;
    const p_piva = partita_iva || null;
    const p_cf = cf || null;
    const p_citta = citta || null;
    const p_contatto = contatto || null;

    logger.debug({ p_ragione_sociale, p_piva }, "Call FetchFornitori");

    // Chiama la stored procedure con i parametri
    const [results] = await db.query("CALL FetchFornitori(?,?,?,?,?,?)", [
      p_codice,
      p_ragione_sociale,
      p_piva,
      p_contatto,
      p_cf,
      p_citta,
    ]);

    // La libreria mysql2 restituisce un array di array per le stored procedures,
    // il primo elemento contiene le righe di dati.
    const rows = results[0];

    logger.debug({ rows: rows.length }, "Rows returned FetchFornitori");
    logger.trace({ rows }, "Rows content");
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero dei fornitori:", error.message);
    next(error);
  }
};

// POST - Inserisce un nuovo fornitore usando la Stored Procedure InsertFornitore
exports.insertFornitore = async (req, res, next) => {
  try {
    const { codice, rag_soc, partita_iva, indirizzo, telefono, email, contatto } =
      req.body;

    const [results] = await db.query("CALL InsertFornitore(?,?,?,?,?,?.?)", [
      codice,
      rag_soc,
      partita_iva,
      indirizzo,
      telefono,
      email,
      contatto,
    ]);

    const newId = results[0][0].id; // Assumendo che la SP restituisca l'ID come 'id'

    res.status(201).json({
      success: true,
      id: newId,
      message: "Fornitore creato con successo.",
    });
  } catch (error) {
    console.error("Errore nell'inserimento del fornitore:", error.message);
    next(error);
  }
};

// PUT - Modifica un fornitore esistente usando la Stored Procedure UpdateFornitore
exports.updateFornitore = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { codice, rag_soc, partita_iva, indirizzo, telefono, email, contatto } =
      req.body;

    await db.query("CALL UpdateFornitore(?,?,?,?,?,?,?,?)", [
      id,
      codice,
      rag_soc,
      partita_iva,
      indirizzo,
      telefono,
      email,
      contatto,
    ]);

    res.json({ success: true, message: "Fornitore aggiornato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'aggiornamento del fornitore con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};

// DELETE - Elimina un fornitore usando la Stored Procedure DeleteFornitore
exports.deleteFornitore = async (req, res, next) => {
  try {
    const { id } = req.params;
    await db.query("CALL DeleteFornitore(?)", [id]);
    res.json({ success: true, message: "Fornitore eliminato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'eliminazione del fornitore con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};
