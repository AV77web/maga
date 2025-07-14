//==================================================
// File: controllers/movimenticontrollers.js
// Controller per le operazioni sui movimenti di magazzino
//==================================================
const db = require("../db/db");
const mytimestamp = require("../timestamp");
const { createCrudHandlers } = require("./crudHandlers");
const logger = require("../utils/logger");
logger.info("Caricamento movimenticontrollers.js con filtri");

// --------------------------------------------------
// ADMIN customQuery super-protetta (accorciata qui)
// --------------------------------------------------
exports.customQuery = async (req, res, next) => {
  /* … codice di sicurezza omesso per brevità … */
};

// --------------------------------------------------
// GET /api/v1/movements – paginazione + filtri
// --------------------------------------------------
exports.getMovimenti = async (req, res, next) => {
  try {
    // Query-params in arrivo
    const {
      idart,
      codice_cau,
      dataDa,
      dataA,
      page = 1,
      page_size = 10,
      order_by = "data",
      order_dir = "DESC",
    } = req.query;

    // Normalizzazioni
    const p_page       = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size  = Math.max(parseInt(page_size, 10) || 10, 1);
    const p_order_by   = order_by;
    const p_order_dir  = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      {
        idart,
        codice_cau,
        dataDa,
        dataA,
        page,
        page_size,
        order_by,
        order_dir,
      },
      "Call FetchMovimenti"
    );

    // La stored-procedure corrente richiede 8 parametri
    const [resultSets] = await db.query(
      "CALL FetchMovimenti(?,?,?,?,?,?,?,?)",
      [
        codice_cau || null, // 1
        idart      || null, // 2
        dataDa     || null, // 3
        dataA      || null, // 4
        p_page,             // 5
        p_page_size,        // 6
        p_order_by,         // 7
        p_order_dir,        // 8
      ]
    );

    // Decodifica output { rows, meta }
    let rows, meta;
    if (
      Array.isArray(resultSets) &&
      resultSets.length >= 2 &&
      resultSets[0][0]?.data !== undefined
    ) {
      // Formato JSON_ARRAYAGG + JSON_OBJECT
      const rawRows = resultSets[0][0].data;
      const rawMeta = resultSets[1][0].meta;
      rows = typeof rawRows === 'string' ? JSON.parse(rawRows) : rawRows;
      meta = typeof rawMeta === 'string' ? JSON.parse(rawMeta) : rawMeta;
    } else {
      // Fallback legacy
      rows = resultSets[0];
      meta = {
        page: p_page,
        pageSize: p_page_size,
        totalRows: rows.length,
        status: "success",
      };
    }

    // Se per qualche motivo la SP ha restituito più record del richiesto, taglia lato server
    if (Array.isArray(rows) && rows.length > meta.pageSize) {
      const start = (meta.page - 1) * meta.pageSize;
      rows = rows.slice(start, start + meta.pageSize);
    }

    logger.debug({ rows: rows.length, meta }, "Rows returned FetchMovimenti");

    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({msg: 'Errore FetchMovimenti', error: error.message, stack: error.stack});
    next(error);
  }
};

// --------------------------------------------------
// POST   /api/v1/movements
// --------------------------------------------------
exports.insertMovimento = async (req, res, next) => {
  const timestamp = mytimestamp().trim();
  const { idart, codice_cau, data, quantita, tipo, note, user } = req.body;

  try {
    const [results] = await db.query(
      "CALL Insert_Movimento(?, ?, ?, ?, ?, ?, ?, ?)",
      [idart, codice_cau, data, quantita, tipo, note, user, timestamp]
    );

    res
      .status(201)
      .json({
        success: true,
        id: results[0][0].insertId,
        message: "Movimento registrato e articolo aggiornato.",
      });
  } catch (error) {
    next(error);
  }
};

// --------------------------------------------------
// PUT    /api/v1/movements/:id  (solo note per ora)
// --------------------------------------------------
exports.updateMovimento = async (req, res, next) => {
  const { id } = req.params;
  const { note } = req.body;

  if (note === undefined) {
    return res.status(400).json({
      success: false,
      message: "Nessun dato fornito per l'aggiornamento.",
    });
  }

  try {
    const [results] = await db.query("CALL UpdateMovimento(?, ?)", [id, note]);
    if (results[0][0].affectedRows > 0) {
      res.json({ success: true, message: "Movimento aggiornato." });
    } else {
      res.status(404).json({ success: false, message: "Movimento non trovato." });
    }
  } catch (error) {
    next(error);
  }
};
