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
    // Estrai i parametri dalla query string con valori di default
    const {
      page = 1,
      pageSize = 10,
      orderBy = "id_ordine",
      orderDir = "DESC",
      num_ordine = null,
      data_da = null,
      data_a = null,
      idanagrafica = null,
    } = req.query;

    const sanitizedOrderDir = (orderDir || "DESC").toUpperCase();
    if (sanitizedOrderDir !== "ASC" && sanitizedOrderDir !== "DESC") {
      // Fallback to a safe default if the value is invalid
      sanitizedOrderDir = "DESC";
    }

    // Validazione del parametro orderBy per corrispondere ai valori accettati dalla stored procedure
    const validOrderByValues = ['id_ordine', 'num_ordine', 'data_ordine', 'idanagrafica', 'stato'];
    const sanitizedOrderBy = validOrderByValues.includes(orderBy) ? orderBy : 'id_ordine';

    const query = `CALL FetchOrdini1(?, ?, ?, ?, ?, ?, ?, ?);`;

    const [results] = await db.query(query, [
      num_ordine,
      idanagrafica ? parseInt(idanagrafica, 10) : null,
      data_da,
      data_a,
      parseInt(page, 10),
      parseInt(pageSize, 10),
      sanitizedOrderBy,
      sanitizedOrderDir,
    ]);

    // La stored procedure restituisce un singolo campo 'result' che è un oggetto JSON
    if (results.length > 0 && results[0][0] && results[0][0].result) {
      const resultData = results[0][0].result;

      // Il JSON viene parsato automaticamente dal driver mysql2 se è un tipo JSON valido
      // Se 'data' è un array vuoto, JSON_ARRAYAGG produce 'null' che dobbiamo trasformare in '[]'
      if (resultData.data === null) {
        resultData.data = [];
      }

      res.status(200).json(resultData);
    } else {
      // Se non ci sono risultati, restituiamo una struttura standard
      res.status(200).json({
        status: "success",
        page: parseInt(page, 10),
        pageSize: parseInt(pageSize, 10),
        totalRows: 0,
        data: [],
      });
    }
  } catch (error) {
    logger.error({
      msg: "Errore in getOrdini",
      error: error.message,
      stack: error.stack,
    });
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
      return res
        .status(400)
        .json({ success: false, message: "ID Ordine mancante." });
    }

    const resultArr = await db.query("CALL FetchOrdineById(?)", [id]);
    //console.log('FetchOrdineById FULL RESULT:', JSON.stringify(resultArr, null, 2));

    const result = resultArr[0][0][0];
    //console.log('FetchOrdineById raw result:', result);

    const response = result && result.result ? result.result : null;
    //console.log('FetchOrdineById parsed response:', response);

    if (!response || response.status !== "success") {
      console.log("RESPONSE 404:", response);
      return res
        .status(404)
        .json({ success: false, message: "Ordine non trovato." });
    }

    res.json({ success: true, data: response.data });
  } catch (error) {
    logger.error({
      msg: `Errore FetchOrdineById con id ${req.params.id}`,
      error: error.message,
      stack: error.stack,
    });
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
      return res
        .status(400)
        .json({ success: false, message: "ID Ordine mancante." });
    }

    const {
      page = 1,
      page_size = 50,
      order_by = "id_riga",
      order_dir = "ASC",
    } = req.query;

    const p_page = Math.max(parseInt(page, 10) || 1, 1);
    const p_page_size = Math.max(parseInt(page_size, 10) || 50, 1);
    const p_order_by = order_by;
    const p_order_dir = order_dir.toUpperCase() === "DESC" ? "DESC" : "ASC";

    const [resultSets] = await db.query("CALL FetchOrdini_righe(?,?,?,?,?)", [
      ordineId,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    console.log("DEBUG resultSets:", JSON.stringify(resultSets, null, 2));

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
        totalRows: rows.length,
        status: "success",
      };
    }
    console.log("DEBUG rawRows:", JSON.stringify(rawRows, null, 2));
    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    logger.error({
      msg: "Errore FetchOrdini_righe",
      error: error.message,
      stack: error.stack,
    });
    next(error);
  }
};

// POST: crea un nuovo ordine
exports.insertOrdine = async (req, res, next) => {
  try {
    const { num_ordine, data_ordine, idanagrafica, stato, note } = req.body;

    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query(
      "CALL InsertOrdini1(?, ?, ?, ?, ?)",
      [num_ordine, data_ordine, Number(idanagrafica), stato, note || null]
    );

    if (response.status === "error") {
      // Errore di validazione o logica di business dalla SP
      return res
        .status(400)
        .json({ success: false, message: response.message });
    }

    res.status(201).json({ success: true, ...response });
  } catch (error) {
    logger.error({
      msg: "Errore in insertOrdine",
      error: error.message,
      stack: error.stack,
    });
    next(error);
  }
};

// PUT: aggiorna un ordine esistente
exports.updateOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;
    const { num_ordine, data_ordine, idanagrafica, stato, note } = req.body;

    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query(
      "CALL UpdateOrdini1(?, ?, ?, ?, ?, ?)",
      [
        id_ordine,
        num_ordine,
        data_ordine,
        Number(idanagrafica),
        stato,
        note || null,
      ]
    );

    if (response.status === "error" || response.rowsAffected === 0) {
      return res.status(404).json({
        success: false,
        message: response.message || "Ordine non trovato o dati invariati.",
      });
    }

    res.json({ success: true, ...response });
  } catch (error) {
    logger.error({
      msg: `Errore nell'aggiornamento dell'ordine con ID ${req.params.id_ordine}:`,
      error: error.message,
      stack: error.stack,
    });
    next(error);
  }
};

// DELETE: elimina un ordine
exports.deleteOrdine = async (req, res, next) => {
  try {
    const { id_ordine } = req.params;

    // Chiama la nuova SP e si aspetta un singolo oggetto JSON `response`
    const [[{ response }]] = await db.query("CALL DeleteOrdini1(?)", [
      id_ordine,
    ]);

    if (response.status === "error") {
      return res
        .status(404)
        .json({ success: false, message: response.message });
    }

    res.json({ success: true, ...response });
  } catch (error) {
    logger.error({
      msg: `Errore nell'eliminazione dell'ordine con ID ${req.params.id_ordine}:`,
      error: error.message,
      stack: error.stack,
    });
    next(error);
  }
};
