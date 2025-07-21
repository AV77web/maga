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

    const p_num_ordine   = num_ordine || null;
    const p_fornitore_id = fornitore_id || null;
    const p_page         = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size    = Math.max(parseInt(page_size, 10) || 10, 1);
    const p_order_by     = order_by || "num_ordine";
    const p_order_dir    = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    logger.debug(
      { p_num_ordine, p_fornitore_id, p_page, p_page_size, p_order_by, p_order_dir },
      "Call FetchOrdini1"
    );
  c
    // Chiama la nuova stored procedure che restituisce un singolo JSON
    const [resultSet] = await db.query("CALL FetchOrdini1(?,?,?,?,?,?)", [
      p_num_ordine,
      p_fornitore_id,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);
    

    // CORRECTED PARSING: Safely extract the result JSON from the nested structure
    const spResult = resultSet && resultSet[0] && resultSet[0][0] ? resultSet[0][0].result : null;

    // Handle the result
    if (spResult && spResult.status === 'success') {
      const rows = spResult.data || [];
      const meta = {
      page: spResult.page,
      pageSize: spResult.pageSize,
      totalRows: spResult.totalRows,
      status: spResult.status,
    };
    logger.debug({ rows: rows.length, meta }, "Rows returned FetchOrdini1");
    res.json({ success: true, result: { rows, meta } });
    } else {
    logger.warn({ msg: "FetchOrdini1 non ha restituito risultati validi, invio array vuoto." });
    res.json({ 
      success: true, 
      result: { 
      rows: [], 
      meta: { page: p_page, pageSize: p_page_size, totalRows: 0, status: 'success' } 
    } 
  });
}

} catch (error) {
logger.error({ msg: "Errore FetchOrdini", error: error.message, stack: error.stack });
next(error);
}
};

// --------------------------------------------------
// GET /api/v1/orders/:id  – recupera un singolo ordine
// --------------------------------------------------
exports.getOrdineById = async (req, res, next) => {
  try {
    const { id } = req.params;
    if (!id) {
      return res.status(400).json({ success: false, message: "ID Ordine mancante." });
    }

    const [[result]] = await db.query("CALL FetchOrdineById(?)", [id]);
    
    // La SP restituisce un singolo campo 'result' che contiene l'oggetto JSON di risposta.
    const response = result.result;

    if (!response || response.status === 'not_found') {
      return res.status(404).json({ success: false, message: "Ordine non trovato." });
    }

    // Passiamo direttamente l'oggetto 'data' estratto dalla risposta della SP.
    res.json({ success: true, data: response.data });

  } catch (error) {
    logger.error({ msg: `Errore FetchOrdineById con id ${req.params.id}`, error: error.message, stack: error.stack });
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
    const { num_ordine, data_ordine, fornitore_id, stato, note } = req.body;
    
    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query("CALL InsertOrdini1(?, ?, ?, ?, ?)", [
      num_ordine,
      data_ordine,
      Number(fornitore_id),
      stato,
      note || null,
    ]);

    if (response.status === 'error') {
      // Errore di validazione o logica di business dalla SP
      return res.status(400).json({ success: false, message: response.message });
    }

    res.status(201).json({ success: true, ...response });
  } catch (error) {
    logger.error({ msg: "Errore in insertOrdine", error: error.message, stack: error.stack });
    next(error);
  }
};

// PUT: aggiorna un ordine esistente
exports.updateOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;
    const { num_ordine, data_ordine, fornitore_id, stato, note } = req.body;

    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query("CALL UpdateOrdini1(?, ?, ?, ?, ?, ?)", [ 
      id_ordine, 
      num_ordine, 
      data_ordine, 
      Number(fornitore_id), 
      stato, 
      note || null
    ]);
    
    if (response.status === 'error' || response.rowsAffected === 0) {
      return res.status(404).json({ success: false, message: response.message || 'Ordine non trovato o dati invariati.' });
    }

    res.json({ success: true, ...response });
  } catch (error) {
    logger.error({ msg: `Errore nell'aggiornamento dell'ordine con ID ${req.params.id_ordine}:`, error: error.message, stack: error.stack });
    next(error);
  }
};

// DELETE: elimina un ordine
exports.deleteOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;

    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query("CALL DeleteOrdini1(?)", [id_ordine]);

    if (response.status === 'error') {
        return res.status(404).json({ success: false, message: response.message });
    }
    
    res.json({ success: true, ...response });
  } catch (error) {
    logger.error({ msg: `Errore nell'eliminazione dell'ordine con ID ${req.params.id_ordine}:`, error: error.message, stack: error.stack });
    next(error);
  }
};