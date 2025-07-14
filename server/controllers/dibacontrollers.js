// ================================
//File: // controllers//dibacontrollers.js
//Script che crea i controller per le operazioni sulle diba
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const db = require("../db/db"); 
const logger = require("../utils/logger");


(async () => {
  try {
    // Test query per verificare la connessione al db
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    logger.info({ msg: "Connessione DB diba OK", result: rows[0] });
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per diba:", err.message);
  }
})();


exports.getAllDiBa = async (req, res, next) => {
  try {
    const [results] = await db.query('CALL FetchDiba(NULL, NULL, NULL)');
    res.json({ success: true, data: results[0] });
  } catch (error) {
    next(error);
  }
};

exports.getDiBaById = async (req, res, next) => {
  const { id } = req.params;
  try {
    const [results] = await db.query('CALL FetchDiba(?, NULL, NULL)', [id]);
    if (results[0].length === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata.' });
    }
    res.json({ success: true, data: results[0][0] });
  } catch (error) {
    next(error);
  }
};

exports.insertDiBa = async (req, res, next) => {
  const { id_father, id_son, quantita } = req.body;
  try {
    const [results] = await db.query('CALL InsertDiba(?, ?, ?)', [id_father, id_son, quantita]);
    const insertId = results[0][0].insertId;
    res.status(201).json({ success: true, id: insertId, message: 'Riga distinta base creata con successo.' });
  } catch (error) {
    next(error);
  }
};

exports.updateDiBa = async (req, res, next) => {
  const { id } = req.params;
  const { quantita } = req.body;

  try {
    const [results] = await db.query('CALL UpdateDiba(?, ?)', [id, quantita]);
    if (results[0][0].affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata per l\'aggiornamento.' });
    }
    res.json({ success: true, message: 'Riga distinta base aggiornata con successo.' });
  } catch (error) {
    next(error);
  }
};

exports.deleteDiBa = async (req, res, next) => {
  const { id } = req.params;
  try {
    const [results] = await db.query('CALL DeleteDiba(?)', [id]);
    if (results[0][0].affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata per l\'eliminazione.' });
    }
    res.json({ success: true, message: 'Riga distinta base eliminata con successo.' });
  } catch (error) {
    next(error);
  }
};

// Funzione per recuperare i componenti dell DiBa (Bill of Material);
exports.getBomByFatherId = async (req, res, next) => {
  const fatherId = req.params.fatherId;

  if (!fatherId) {
    return res
      .status(400)
      .json({ success: false, message: "ID articolo padre mancante o non valido" });
  }

  const {
    page = 1,
    page_size = 10,
    order_by = "id_son",
    order_dir = "ASC",
  } = req.query;

  const p_page       = Math.max(parseInt(page, 10) || 1, 1);
  const p_page_size  = Math.max(parseInt(page_size, 10) || 10, 1);
  const p_order_by   = order_by;
  const p_order_dir  = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

  logger.debug({ fatherId, p_page, p_page_size, p_order_by, p_order_dir }, "Call FetchDiba");

  try {
    // La SP accetta 5 parametri
    const [resultSets] = await db.query("CALL FetchDiba(?,?,?,?,?)", [
      fatherId,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    let rows, meta;
    if (
      Array.isArray(resultSets) &&
      resultSets.length >= 2 &&
      resultSets[0][0]?.data !== undefined
    ) {
      const rawRows = resultSets[0][0].data;
      const rawMeta = resultSets[1][0]?.meta ?? {};
      rows = typeof rawRows === "string" ? JSON.parse(rawRows) : rawRows;
      meta = typeof rawMeta === "string" ? JSON.parse(rawMeta) : rawMeta;
    } else {
      rows = resultSets[0];
      meta = {
        page: p_page,
        pageSize: p_page_size,
        totalRows: Array.isArray(rows) ? rows.length : 0,
        status: "success",
      };
    }

    // Safety slice
    if (Array.isArray(rows) && rows.length > meta.pageSize) {
      const start = (meta.page - 1) * meta.pageSize;
      rows = rows.slice(start, start + meta.pageSize);
    }

    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({ msg: `Errore FetchDiba father ${fatherId}`, error: error.message, stack: error.stack });
    next(error);
  }
};