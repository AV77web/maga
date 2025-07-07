//============================================
//File: ordinicontrollers.js
//Script che crea i controller per le operazioni 
//sugli ordini
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2025-07-08"
//==============================================

const db = require("../db/db");

(async () => {
    try{
        const [rows] = await db.query("SELECT 1 + 1 AS result");
        console.log("✅ Connessione al database per ordini OK:" , rows[0]);
    } catch (err) {
        console.error("❌ ERRORE connessione al DB per ordini:", err.message);
    }
})();

// Funzione di validazione specifica per gli ordini
function validateOrdineInput(data, operation) {
    const { ordine_num, data_ordine, id_fornitore, stato } = data;
    if (!ordine_num || typeof ordine_num !== 'string' || ordine_num.trim() === '') {
        return "Il campo 'ordine_num' è obbligatorio e deve essere una stringa non vuota.";
    }
    if (!data_ordine) { // Controllo base, può essere migliorato con validazione della data
        return "Il campo 'data_ordine' è obbligatorio.";
    }
    // Converte l'ID fornitore in numero per una validazione robusta
    const fornitoreId = Number(id_fornitore);
    if (id_fornitore === undefined || isNaN(fornitoreId) || fornitoreId <= 0) {
        return "Il campo 'id_fornitore' è obbligatorio e deve essere un numero valido.";
    }
    if (!stato || !['Aperto', 'Chiuso', 'Annullato'].includes(stato)) {
        return "Il campo 'stato' è obbligatorio e deve essere 'Aperto', 'Chiuso', o 'Annullato'.";
    }
    // Aggiungere altre validazioni se necessario (es. per le righe d'ordine)
    return null; // Nessun errore
}

// GET tutti gli ordini, con gestione dei filtri
exports.getOrdini = async (req, res, next) => {
  try {
    // Estrai i possibili filtri da req.query
    const { ordine_num, id_fornitore, stato, data_da, data_a } = req.query;

    // Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const params = [
      ordine_num || null,
      id_fornitore || null,
      stato || null,
      data_da || null,
      data_a || null
    ];

    console.log(
      "[OrdiniController] Chiamata alla Stored Procedure FetchOrdini con parametri:",
      { ordine_num, id_fornitore, stato, data_da, data_a }
    );

    // Assumendo che esista una SP 'FetchOrdini' che accetta questi filtri
    const [results] = await db.query("CALL FetchOrdini(?, ?, ?, ?, ?)", params);

    const rows = results[0];

    console.log("[OrdiniController] Righe dal DB:", rows.length);
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero degli ordini:", error.message);
    next(error);
  }
};

// GET righe di un ordine specifico
exports.getOrdineRighe = async (req, res, next) => {
  try {
    const { ordineId } = req.params;
    if (!ordineId) {
      return res.status(400).json({ success: false, message: "ID Ordine mancante." });
    }

    // Assumendo una SP 'FetchOrdineRighe' che accetta l'ID dell'ordine
    const [results] = await db.query("CALL FetchOrdineRighe(?)", [ordineId]);
    const rows = results[0];
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error(`Errore nel recupero delle righe per l'ordine ID ${req.params.ordineId}:`, error.message);
    next(error);
  }
};

// POST: crea un nuovo ordine
exports.insertOrdine = async (req, res, next) => {
  try {
    // Crea una copia del body per poter convertire i tipi senza modificare l'originale
    const dataToValidate = { ...req.body };
    if (dataToValidate.id_fornitore) {
        dataToValidate.id_fornitore = Number(dataToValidate.id_fornitore);
    }

    const validationError = validateOrdineInput(dataToValidate, "create");
    if (validationError) {
      return res.status(400).json({ success: false, message: validationError });
    }

    const { ordine_num, data_ordine, id_fornitore, stato, note } = dataToValidate;
    
    // Assumendo una SP 'InsertOrdine'
    const [results] = await db.query("CALL InsertOrdine(?, ?, ?, ?, ?)", [
      ordine_num,
      data_ordine,
      id_fornitore,
      stato,
      note || null,
    ]);

    const newId = results[0][0].id; // Assumendo che la SP restituisca l'ID

    res.status(201).json({ success: true, id: newId, message: "Ordine creato con successo." });
  } catch (error) {
    console.error("Errore nell'inserimento dell'ordine:", error.message);
    next(error);
  }
};

// PUT: aggiorna un ordine esistente
exports.updateOrdine = async (req, res, next) => {
  try {
    const { id } = req.params;

    const dataToValidate = { ...req.body };
    if (dataToValidate.id_fornitore) {
        dataToValidate.id_fornitore = Number(dataToValidate.id_fornitore);
    }

    const validationError = validateOrdineInput(dataToValidate, "update");
    if (validationError) {
      return res.status(400).json({ success: false, message: validationError });
    }

    const { ordine_num, data_ordine, id_fornitore, stato, note } = dataToValidate;

    // Assumendo una SP 'UpdateOrdine'
    const [result] = await db.query("CALL UpdateOrdine(?, ?, ?, ?, ?, ?)", [ id, ordine_num, data_ordine, id_fornitore, stato, note || null]);
    
    if (result.affectedRows === 0) {
        return res.status(404).json({ success: false, message: "Ordine non trovato per l'aggiornamento." });
    }

    res.json({ success: true, message: "Ordine aggiornato con successo." });
  } catch (error) {
    console.error(`Errore nell'aggiornamento dell'ordine con ID ${req.params.id}:`, error.message);
    next(error);
  }
};

// DELETE: elimina un ordine
exports.deleteOrdine = async (req, res, next) => {
  try {
    const { id } = req.params;

    // Assumendo una SP 'DeleteOrdine'
    const [result] = await db.query("CALL DeleteOrdine(?)", [id]);

    if (result.affectedRows === 0) {
        return res.status(404).json({ success: false, message: "Ordine non trovato per l'eliminazione." });
    }

    res.json({ success: true, message: "Ordine eliminato con successo." });
  } catch (error) {
    console.error(`Errore nell'eliminazione dell'ordine con ID ${req.params.id}:`, error.message);
    next(error);
  }
};