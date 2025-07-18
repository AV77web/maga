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
      cf,
      partita_iva,
      citta,
      contatto,
      page = 1,
      page_size = 10,
      order_by = "rag_soc",
      order_dir = "ASC",
    } = req.query;

    const p_rag_soc = rag_soc || null;
    const p_tipo = tipo || null;
    const p_cf = cf || null;
    const p_partita_iva = partita_iva || null;
    const p_citta = citta || null;
    const p_contatto = contatto || null;
    const p_page = toPositiveInt(page);
    const p_page_size = toPositiveInt(page_size, 10);

    const validOrderFields = [
      'id', 'codice', 'rag_soc', 'tipo', 'cf', 'partita_iva', 'citta', 'telefono', 'email', 'contatto'
    ];
    const p_order_by = validOrderFields.includes(order_by) ? order_by : 'rag_soc';
    const p_order_dir = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      { p_rag_soc, p_tipo, p_cf, p_partita_iva, p_citta, p_contatto, p_page, p_page_size, p_order_by, p_order_dir },
      "Call FetchControparti"
    );

    const [resultSets] = await db.query(
      "CALL FetchControparti(?,?,?,?,?,?,?,?,?,?)",
      [
        p_rag_soc,
        p_tipo,
        p_cf,
        p_partita_iva,
        p_citta,
        p_contatto,
        p_page,
        p_page_size,
        p_order_by,
        p_order_dir,
      ]
    );

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
  console.log('DEBUG BODY:', req.body); // <--- AGGIUNGI QUI
  try {
    // Estrarre i campi payload secondo lo schema JSON
    const {
      codice,
      rag_soc,
      tipo,
      cf,
      partita_iva,
      indirizzo,
      citta,
      cap,
      pv,
      nazione,
      telefono,
      email,
      sito_web,
      contatto,
      note,
      ruolo,
    } = req.body;

    const [results] = await db.query(
      "CALL InsertControparte(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
      [
        codice,
        rag_soc,
        tipo,
        cf,
        partita_iva,
        indirizzo,
        citta,
        cap,
        pv,
        nazione,
        telefono,
        email,
        sito_web,
        contatto,
        note,
        ruolo,
      ]
    );

    // Le stored procedure restituiscono un array con la risposta JSON
    const response = results[0][0];
    if (response.status === 'error') {
      throw new Error(response.message);
    }

    const newId = response.insertId;

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
      codice,
      rag_soc,
      tipo,
      cf,
      partita_iva,
      indirizzo,
      citta,
      cap,
      pv,
      nazione,
      telefono,
      email,
      contatto,
      sito_web,
      note,
      ruolo,
    } = req.body;

    const [results] = await db.query("CALL UpdateControparte(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [
      id,
      codice,
      rag_soc,
      tipo,
      cf,
      partita_iva,
      indirizzo,
      citta,
      cap,
      pv,
      nazione,
      telefono,
      email,
      contatto,
      sito_web,
      note,
      ruolo,
    ]);

    // Le stored procedure restituiscono un array con la risposta JSON
    const response = results[0][0];
    if (response.status === 'error') {
      throw new Error(response.message);
    }

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
    const [results] = await db.query("CALL DeleteControparte(?)", [id]);
    
    // Le stored procedure restituiscono un array con la risposta JSON
    const response = results[0][0];
    if (response.status === 'error') {
      throw new Error(response.message);
    }

    res.json({ success: true, message: "Controparte eliminata con successo." });
  } catch (error) {
    logger.error({ msg: "Errore deleteCounterparty", err: error.message });
    next(error);
  }
}; 