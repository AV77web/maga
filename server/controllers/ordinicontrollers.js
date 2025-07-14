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

// --------------------------------------------------
// GET /api/v1/orders  – paginazione + filtri
// --------------------------------------------------
exports.getOrdini = async (req, res, next) => {
  try {
    const {
      num_ordine,
      fornitore_id,
      page = 1,
      page_size = 10,
      order_by = "num_ordine",
      order_dir = "ASC",
    } = req.query;

    // Normalizzazioni / default
    const p_num_ordine   = num_ordine || null;
    const p_fornitore_id = fornitore_id || null;
    const p_page         = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size    = Math.max(parseInt(page_size, 10) || 10, 1);
    /* Mappa i nomi colonna usati sul frontend (id) a quelli reali nel DB */
    const orderMap = {
      id: "id_ordine",
      num_ordine: "num_ordine",
      data_ordine: "data_ordine",
      fornitore_id: "fornitore_id",
      stato: "stato",
    };

    const p_order_by     = orderMap[order_by] || order_by;
    const p_order_dir    = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      {
        p_num_ordine,
        p_fornitore_id,
        p_page,
        p_page_size,
        p_order_by,
        p_order_dir,
      },
      "Call FetchOrdini"
    );

    // La nuova SP accetta 6 parametri (2 filtri + paginazione + ordinamento)
    const [resultSets] = await db.query("CALL FetchOrdini(?,?,?,?,?,?)", [
      p_num_ordine,
      p_fornitore_id,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    // Decodifica output { rows, meta }
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
      // Fallback legacy (non JSON aggregato)
      rows = resultSets[0];
      meta = {
        page: p_page,
        pageSize: p_page_size,
        totalRows: Array.isArray(rows) ? rows.length : 0,
        status: "success",
      };
    }

    // Safety slice nel caso la SP restituisca più righe del previsto
    if (Array.isArray(rows) && rows.length > meta.pageSize) {
      const start = (meta.page - 1) * meta.pageSize;
      rows = rows.slice(start, start + meta.pageSize);
    }

    logger.debug({ rows: rows.length, meta }, "Rows returned FetchOrdini");
    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({ msg: "Errore FetchOrdini", error: error.message, stack: error.stack });
    next(error);
  }
};

// --------------------------------------------------
// GET /api/v1/orders/:orderId/items – paginazione minima
// --------------------------------------------------
exports.getOrdineRighe = async (req, res, next) => {
  try {
    const { ordineId } = req.params;
    if (!ordineId) {
      return res.status(400).json({ success: false, message: "ID Ordine mancante." });
    }

    const {
      page = 1,
      page_size = 50,
      order_by = "id_riga",
      order_dir = "ASC",
    } = req.query;

    const p_page        = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size   = Math.max(parseInt(page_size, 10) || 50, 1);
    const p_order_by    = order_by;
    const p_order_dir   = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    const [resultSets] = await db.query("CALL FetchOrdini_righe(?,?,?,?,?)", [
      ordineId,
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
      meta = { page: p_page, pageSize: p_page_size, totalRows: rows.length, status: "success" };
    }

    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({ msg: "Errore FetchOrdini_righe", error: error.message, stack: error.stack });
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