//============================================================
// File: ordinilinecontrollers.js
// Controller per la gestione delle righe ordine (ordini_righe)
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-16"
//============================================================

const db = require('../db/db');

// GET tutte le righe di un ordine
exports.getOrderLines = async (req, res, next) => {
  try {
    const { orderId } = req.params;
    const [resultSets] = await db.query('CALL FetchOrdini_righe(?,1,100,"id_riga", "ASC")', [orderId]);
    res.json({ success: true, rows: resultSets[0] });
  } catch (err) {
    next(err);
  }
};

// POST nuova riga ordine
exports.insertOrderLine = async (req, res, next) => {
  try {
    const { id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita } = req.body;
    const [result] = await db.query('CALL InsertOrdini_righe(?,?,?,?,?)', [
      id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita
    ]);
    res.status(201).json({ success: true, id: result[0]?.id_riga });
  } catch (err) {
    next(err);
  }
};

// PUT aggiorna riga ordine
exports.updateOrderLine = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita } = req.body;
    await db.query('CALL UpdateOrdini_righe(?,?,?,?,?,?)', [
      id, id_ordine, nome_articolo, descrizione, prezzo_unitario, quantita
    ]);
    res.json({ success: true });
  } catch (err) {
    next(err);
  }
};

// DELETE riga ordine
exports.deleteOrderLine = async (req, res, next) => {
  try {
    const { id } = req.params;
    const [result] = await db.query('CALL DeleteOrdini_righe(?)', [id]);
    // La SP restituisce un JSON_OBJECT come response
    const response = result[0]?.response ? JSON.parse(result[0].response) : null;
    if (response && response.status === 'success') {
      res.json({ success: true, ...response });
    } else {
      res.status(404).json({ success: false, ...response });
    }
  } catch (err) {
    next(err);
  }
}; 