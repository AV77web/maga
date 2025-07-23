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

// GET ordine righe
exports.getOrdineRighe = async (req, res, next) => {
  try {
    const ordineId = Number(req.params.id);
    const p_page = Number(req.query.page) || 1;
    const p_page_size = Number(req.query.pageSize) || 50;
    const p_order_by = req.query.orderBy || 'id_riga';
    const p_order_dir = req.query.orderDir || 'ASC';

    const resultSets = await db.query("CALL FetchOrdini_righe1(?,?,?,?,?)", [
      ordineId,
      p_page,
      p_page_size,
      p_order_by,
      p_order_dir,
    ]);

    const allRows = resultSets[0] || [];

    if (!allRows.length) {
      return res.json({
        success: true,
        result: {
          rows: [],
          meta: { status: "success", totalRows: 0, page: p_page, pageSize: p_page_size }
        }
      });
    }

    // La stored procedure restituisce un oggetto con chiavi numeriche (0,1,2,...) contenenti i dati delle righe
    // più una riga di metadati MySQL che dobbiamo filtrare
    const dataRow = allRows.find(row => !row.hasOwnProperty('fieldCount')); // Trova la riga con i dati
    
    if (!dataRow) {
      return res.json({
        success: true,
        result: {
          rows: [],
          meta: { status: "success", totalRows: 0, page: p_page, pageSize: p_page_size }
        }
      });
    }

    // Estrai le righe individuali dalle chiavi numeriche
    const rows = [];
    let meta = { status: "success", totalRows: 0, page: p_page, pageSize: p_page_size };
    
    // Itera attraverso le chiavi numeriche per estrarre ogni riga
    for (let i = 0; ; i++) {
      if (dataRow[i.toString()]) {
        const rigaData = dataRow[i.toString()];
        // Estrai i metadati dalla prima riga
        if (i === 0) {
          meta = {
            status: rigaData.status || "success",
            totalRows: rigaData.totalRows || 0,
            page: rigaData.page || p_page,
            pageSize: rigaData.pageSize || p_page_size
          };
        }
        // Aggiungi solo i dati della riga (senza metadati)
        const { status, totalRows, page, pageSize, ...rigaSenzaMetadati } = rigaData;
        rows.push(rigaSenzaMetadati);
      } else {
        break; // Non ci sono più righe
      }
    }

    res.json({ success: true, result: { rows, meta } });
  } catch (error) {
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