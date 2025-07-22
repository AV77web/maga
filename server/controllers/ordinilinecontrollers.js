//============================================================
// File: ordinilinecontrollers.js
// Controller per la gestione delle righe ordine (ordini_righe)
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-16"
//============================================================

const db = require('../db/db');

// GET tutte le righe di un ordine
exports.getOrderLines = async (req, res, next) => {
  console.log("A T T E N Z I O N E...getOrderLines");
  try {
    const { orderId } = req.params;
    const [resultSets] = await db.query('CALL FetchOrdini_righe(?,1,100,"id_riga", "ASC")', [orderId]);
    res.json({ success: true, rows: resultSets[0] });
  } catch (err) {
    next(err);
  }
};

// GET ordine righe
exports.getOrdineRighe = async (req, res, next) => {
  console.log("A T T E N Z I O N E...req.params:", req.params);
  try {
    const ordineId = req.params.id;
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

    // Esegui la stored procedure
    const resultSets = await db.query("CALL FetchOrdini_righe1(?,?,?,?,?)", [
      ordineId,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    console.log("DEBUG resultSets:", JSON.stringify(resultSets, null, 2));

    // resultSets[0] = primo resultset (array di righe con colonna 'data')
    // resultSets[1] = secondo resultset (array di righe con colonna 'meta')
    const rawRows = resultSets[0][0]?.data;
    const rawMeta = resultSets[1][0]?.meta;

    const rows = rawRows ? JSON.parse(rawRows) : [];
    const meta = rawMeta ? JSON.parse(rawMeta) : { page: p_page, pageSize: p_page_size, totalRows: 0, status: "success" };

    console.log("Sto per rispondere con:", { rows, meta });
    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
    // logger.error({ msg: "Errore FetchOrdini_righe", error: error.message, stack: error.stack }); // Assuming logger is defined elsewhere
    next(error);
  }
};

// POST nuova riga ordine
exports.insertOrderLine = async (req, res, next) => {

  try {
    const { id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita } = req.body;
    const [[result]] = await db.query('CALL InsertOrdini_righe(?,?,?,?,?)', [
      id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita
    ]);
    
    const response = result.response;
    if (response.status === 'error') {
        return res.status(400).json({ success: false, message: response.message });
    }
    
    res.status(201).json({ success: true, ...response });
  } catch (err) {
    next(err);
  }
};

// PUT aggiorna riga ordine
exports.updateOrderLine = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita } = req.body;
    const [[result]] = await db.query('CALL UpdateOrdini_righe(?,?,?,?,?,?)', [
      id, id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita
    ]);

    const response = result.response;
    if (response.status === 'error' || response.rowsAffected === 0) {
        return res.status(404).json({ success: false, message: response.message || 'Riga ordine non trovata.' });
    }

    res.json({ success: true, ...response });
  } catch (err) {
    next(err);
  }
};

// DELETE riga ordine
exports.deleteOrderLine = async (req, res, next) => {
  try {
    const { id } = req.params;
    const [[result]] = await db.query('CALL DeleteOrdini_righe(?)', [id]);

    const response = result.response;
    if (response.status === 'error' || response.rowsDeleted === 0) {
        return res.status(404).json({ success: false, message: response.message || 'Riga ordine non trovata.' });
    }

    res.json({ success: true, ...response });
  } catch (err) {
    next(err);
  }
}; 