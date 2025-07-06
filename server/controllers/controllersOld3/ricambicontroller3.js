//==========================================
//File: // controllers//ricambiController.js
//Script che crea i controller per le operazioni sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//==========================================
const { createCrudHandlers } = require('./crudHandlers'); // Assumendo che il file sia in utils
const db = require("../db/db");


(async () => {
  try {
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB:", err.message);
  }
})();

// Funzione di validazione specifica per i ricambi (opzionale, ma consigliata)
function validateRicambioInput(data, operation) {
  const { name, description, quantita, min, max, supplier } = data;
  if (!name || description === undefined || quantita === undefined || min === undefined || max === undefined || supplier === undefined) {
    return "Dati mancanti o incompleti per il ricambio.";
  }
  if (isNaN(Number(quantita)) || Number(quantita) < 0) {
    return "La quantità deve essere un numero non negativo.";
  }
  // Aggiungere altre validazioni se necessario
  return null; // Nessun errore
}

const ricambiCrudHandlers = createCrudHandlers('articoli', { validateInput: validateRicambioInput });

// exports.getRicambi = ricambiCrudHandlers.getAll; // Non usiamo più l'handler generico per GET
exports.insertRicambio = ricambiCrudHandlers.create;
exports.updateRicambio = ricambiCrudHandlers.update;
exports.deleteRicambio = ricambiCrudHandlers.delete;
// Potresti aggiungere exports.getRicambioById = ricambiCrudHandlers.getById; se necessario

// GET tutti i ricambi, con gestione dei filtri
exports.getRicambi = async (req, res) => {
  try {
    // Estrai i possibili filtri da req.query
    // Questi nomi devono corrispondere a quelli usati in ricambiFilterFields nel frontend
    const { name, description, supplier /*, altri filtri se ne hai */ } = req.query;

    /*let sql = `
      SELECT 
        id, 
        name, 
        description, 
        quantita, 
        min, 
        max, 
        supplier 
      FROM articoli 
    `; // Assicurati che 'articoli' sia il nome corretto della tua tabella

    const conditions = [];
    const queryParams = [];

    if (name) {
      conditions.push("name LIKE ?"); 
      queryParams.push(`%${name}%`); // Ricerca parziale
    }
    if (description) {
      conditions.push("description LIKE ?");
      queryParams.push(`%${description}%`); // Ricerca parziale
    }
    if (supplier) {
      conditions.push("supplier LIKE ?");
      queryParams.push(`%${supplier}%`); // Ricerca parziale
    }

    if (conditions.length > 0) {
      sql += " WHERE " + conditions.join(" AND ");
    }

    sql += " ORDER BY name ASC"; // O un altro ordinamento di default

    console.log('[RicambiController] SQL Eseguita:', sql);
    console.log('[RicambiController] Parametri SQL:', queryParams);

    const [rows] = await db.query(sql, queryParams);*/
    
    //==================================================
    //Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const p_name = name || null;
    const p_description = description || null;
    const p_supplier = supplier || null;

    console.log('[RicambiController] Chiamata alla Stored Procedure con GetFilteredRicambi con parametri:', { p_name, p_description, p_supplier });

    // Chiama la sotred procedure con i parametri
    const [results] = await db.query('CALL FetchArticoli(?,?,?)', [p_name, p_description, p_supplier]);
    
    // La libreria mysql2 restituisce un array di array per le stored procedures, 
    // il primo elemento contiene le righe di dati.
    const rows = results[0];
    
    console.log('[RicambiController] Righe dal DB:', rows.length);
    res.json({ success: true, result: rows });

  } catch (error) {
    console.error("Errore nel recupero dei ricambi:", error);

    // ---ADDED DEBUGGING LOGS---
    console.error("[RicambiController] Caught Error Details:");
    console.error("[RicambiController] Error Type:" , typeof error);
    console.error("[RicambiController] Is Error Instance", error instanceof Error);
    console.error("[RicambiController] Error Name:" , error.name);
    console.error("[RicambiController] Error Message:" , error.message);
    console.error("[RicambiController] Error Stack:", error.message);
    // ---END ADDED DEBUGGING LOGS ---
       res.status(500).json({ success: false, error: error.message });
  }
};
