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
    const {
      codice,
      description,
      tipo,
      attiva,
      page = 1,
      page_size = 10,
      order_by = "codice",
      order_dir = "ASC",
    } = req.query;

    const p_codice = codice || null;
    const p_description = description || null;
    const p_tipo = tipo || null;
    const p_attiva = attiva === undefined ? null : Number(attiva);

    const p_page = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size = Math.max(parseInt(page_size, 10) || 10, 1);
    const p_order_by = order_by;
    const p_order_dir = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      {
        p_codice,
        p_description,
        p_tipo,
        p_attiva,
        p_page,
        p_page_size,
        p_order_by,
        p_order_dir,
      },
      "Call FetchCausali"
    );

    // La nuova SP accetta 8 parametri (4 filtri + paginazione + ordinamento)
    const [resultSets] = await db.query("CALL FetchCausali(?,?,?,?,?,?,?,?)", [
      p_codice,
      p_description,
      p_tipo,
      p_attiva,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    let rows;
    let meta;
    if (Array.isArray(resultSets) && resultSets.length >= 2 && resultSets[0][0]?.data !== undefined) {
      const rawRows = resultSets[0][0].data;
      const rawMeta = resultSets[1][0]?.meta ?? {};
      rows = typeof rawRows === "string" ? JSON.parse(rawRows) : rawRows;
      meta = typeof rawMeta === "string" ? JSON.parse(rawMeta) : rawMeta;
    } else {
      rows = resultSets[0];
      meta = { page: p_page, pageSize: p_page_size, totalRows: rows.length, status: "success" };
    }

    logger.debug({ rows: rows.length, meta }, "Rows returned FetchCausali");

    return res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    next(error);
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