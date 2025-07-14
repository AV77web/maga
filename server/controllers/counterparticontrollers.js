/*
==========================================
File: controllers/counterparticontrollers.js
Controller per operazioni sulla tabella unificata "controparti" (clienti + fornitori).
Le stored procedure sono:
  - FetchControparti(p_nome, p_tipo, p_codice_fiscale, p_piva, p_citta, p_contatto, p_page, p_page_size, p_order_by, p_order_dir)
  - InsertControparte(...)
  - UpdateControparte(...)
  - DeleteControparte(p_id)
In caso di assenza di alcune SP, logga un warning.
@author: "villari.andrea@libero.it"
@version: "1.0.0 2025-07-14"
==========================================
*/

const db = require("../db/db");
const logger = require("../utils/logger");

// Utils per mappare i parametri di query in modo sicuro
const toPositiveInt = (value, defaultVal = 1) => {
  const parsed = parseInt(value, 10);
  return Number.isFinite(parsed) && parsed > 0 ? parsed : defaultVal;
};

/**
 * GET /api/v1/counterparties
 * Elenco controparti con paginazione, ordinamento e filtri.
 */
exports.getCounterparties = async (req, res, next) => {
  try {
    const {
      rag_soc,
      tipo, // CLIENTE | FORNITORE | null
      cf, // codice fiscale
      partita_iva,
      citta,
      contatto,
      page = 1,
      page_size = 10,
      order_by = "nome",
      order_dir = "ASC",
    } = req.query;

    const p_nome = rag_soc || null;
    const p_tipo = tipo || null;
    const p_cf = cf || null;
    const p_piva = partita_iva || null;
    const p_citta = citta || null;
    const p_contatto = contatto || null;
    const p_page = toPositiveInt(page);
    const p_page_size = toPositiveInt(page_size, 10);
    const p_order_by = order_by;
    const p_order_dir = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      { p_nome, p_tipo, p_page, p_page_size, p_order_by, p_order_dir },
      "Call FetchControparti"
    );

    // Stored Procedure: FetchControparti
    const [resultSets] = await db.query(
      "CALL FetchControparti(?,?,?,?,?,?,?,?,?,?)",
      [
        p_nome,
        p_tipo,
        p_cf,
        p_piva,
        p_citta,
        p_contatto,
        p_page,
        p_page_size,
        p_order_by,
        p_order_dir,
      ]
    );

    /*
      Supponiamo che la SP restituisca sia i dati sia le meta-info di paginazione
      in due result-set: rows e meta (come già avviene per FetchArticoli).
    */
    if (!Array.isArray(resultSets) || resultSets.length < 2) {
      throw new Error("Formato risposta SP FetchControparti non riconosciuto");
    }

    const rawRows = resultSets[0][0]?.data ?? [];
    const rawMeta = resultSets[1][0]?.meta ?? {};

    const rows = typeof rawRows === "string" ? JSON.parse(rawRows) : rawRows;
    const meta = typeof rawMeta === "string" ? JSON.parse(rawMeta) : rawMeta;

    logger.debug({ rows: rows.length, meta }, "Rows returned FetchControparti");

    return res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({ msg: "Errore getCounterparties", err: error.message });
    next(error);
  }
};

/**
 * POST /api/v1/counterparties
 * Inserisce una nuova controparte
 */
exports.insertCounterparty = async (req, res, next) => {
  try {
    // Estrarre i campi payload
    const {
      rag_soc,
      tipo,
      cf,
      partita_iva,
      indirizzo,
      citta,
      cap,
      provincia,
      nazione,
      telefono,
      email,
      contatto,
      note,
    } = req.body;

    const [results] = await db.query(
      "CALL InsertControparte(?,?,?,?,?,?,?,?,?,?,?,?,?)",
      [
        rag_soc,
        tipo,
        cf,
        partita_iva,
        indirizzo,
        citta,
        cap,
        provincia,
        nazione,
        telefono,
        email,
        contatto,
        note,
      ]
    );

    const newId = results[0][0].id;

    res.status(201).json({
      success: true,
      id: newId,
      message: "Controparte creata con successo.",
    });
  } catch (error) {
    logger.error({ msg: "Errore insertCounterparty", err: error.message });
    next(error);
  }
};

/**
 * PUT /api/v1/counterparties/:id
 * Aggiorna una controparte
 */
exports.updateCounterparty = async (req, res, next) => {
  try {
    const { id } = req.params;
    const {
      nome,
      tipo,
      codice_fiscale,
      partita_iva,
      indirizzo,
      citta,
      cap,
      provincia,
      nazione,
      telefono,
      email,
      contatto,
      note,
    } = req.body;

    await db.query("CALL UpdateControparte(?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [
      id,
      nome,
      tipo,
      codice_fiscale,
      partita_iva,
      indirizzo,
      citta,
      cap,
      provincia,
      nazione,
      telefono,
      email,
      contatto,
      note,
    ]);

    res.json({ success: true, message: "Controparte aggiornata con successo." });
  } catch (error) {
    logger.error({ msg: "Errore updateCounterparty", err: error.message });
    next(error);
  }
};

/**
 * DELETE /api/v1/counterparties/:id
 * Elimina una controparte
 */
exports.deleteCounterparty = async (req, res, next) => {
  try {
    const { id } = req.params;
    await db.query("CALL DeleteControparte(?)", [id]);
    res.json({ success: true, message: "Controparte eliminata con successo." });
  } catch (error) {
    logger.error({ msg: "Errore deleteCounterparty", err: error.message });
    next(error);
  }
}; 