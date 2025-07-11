//==================================================
//File: // controllers//movimenticontrollers.js
//Script che crea i controller per le operazioni sui movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================================
const db = require("../db/db");
const mytimestamp = require("../timestamp");
const { createCrudHandlers } = require('./crudHandlers');
const logger = require('../utils/logger');
logger.info("Caricamento movimenticontrollers.js con filtri");

// Query personalizzata per eseguire un filtro dei dati database sulla tabella dataabase
exports.customQuery = async (req, res, next) => {
  const {query} = req.body;

  if(!query || typeof query !== "string") {
    return res.status(400).json({ success: false, error: "Query mancanete o non valida."});
  }

  try {
    const [rows] = await db.query(query);
    res.json({ success: true, data: rows });
  } catch (error) {
    next(error);
}
};

// GET tutti i movimenti (potresti voler aggiungere filtri, es. per articolo o data)
// Modificato per gestire i filtri da req.query
exports.getMovimenti = async (req, res, next) => {
    try { 
    const { idart, codice_cau, tipo, dataDa, dataA , user} = req.query;

    // Chiama la stored procedure con i parametri, passando null se non presenti
    const [rows] = await db.query(
      'CALL FetchMovimenti(?, ?, ?, ?, ?,?)',
      [
        idart || null,
        dataDa || null,
        dataA || null,
        tipo || null,
        codice_cau || null,
        user || null
      ]
    );
    res.json({ success: true, data: rows[0] });
    //console.log(rows[0]);

  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// POST: nuovo movimento
exports.insertMovimento = async (req, res, next ) => {
  // Esempio di campi per un movimento. Adattali!
  const timestamp = mytimestamp().trim();
  //console.log(timestamp.length);

  const {
    idart,
    codice_cau,
    data,
    quantita,
    tipo,
    note,
    user // <-- Estrai l'utente dal corpo della richiesta
  } = req.body;

  // Controllo dei campi obbligatori (esempio)
  if (
    idart === undefined ||
    codice_cau === undefined ||
    data === undefined ||
    quantita === undefined ||
    !tipo ||
    user === undefined || // <-- La validazione ora funziona correttamente
    timestamp === undefined
  ) {
    return res
      .status(400)
      .json({ success: false, error: "Dati movimento mancanti o incompleti" });
  }
  if (!['C', 'S'].includes(tipo)) {
    return res.status(400).json({
      success: false,
      message: "Il campo 'tipo' deve essere 'C' o 'S'.",
    });
  }
   if (
    isNaN(parseInt(quantita)) ||
    parseInt(quantita) <= 0
  ) {
    return res.status(400).json({ success: false, message: "Quantità movimentata non valida perchè deve essere un numero positivo.", });
  }

  // Aggiungi validazione per codice_cau
  //if (isNaN(parseInt(codice_cau, 10))) {
  //  return res.status(400).json({
  //    success: false,
  //    message: `ID Causale non valido. Previsto un numero, ricevuto: '${codice_cau}'.`
  //  });
  // }

  
  try {
    // Chiama la stored procedure per inserire il movimento
    const [results] = await db.query(
      'CALL Insert_Movimento(?, ?, ?, ?, ?, ?, ? ,? )',
      [  idart, codice_cau, data, quantita, tipo, note, user, timestamp || null]
    );
    //console.log(results);
    // La stored procedure restituisce un set di risultati con l'ID inserito
    const insertId = results[0][0].insertId;

    res
      .status(201)
      .json({
        success: true,
        id: insertId,
        message: "Movimento registrato e articolo aggiornato.",
      });
  } catch (error) {
     
    next(error); // Passa l'errore al middleware centralizzato
  
  }
};

// PUT: modifica movimento (ATTENZIONE: modificare un movimento può essere complesso)
// La modifica di un movimento spesso implica stornare il vecchio movimento e crearne uno nuovo,
// o ricalcolare le giacenze. Questa è una semplificazione.
exports.updateMovimento = async (req, res ,next) => {
  const { id } = req.params;
  // Considera quali campi di un movimento possono essere modificati e l'impatto sulle giacenze.
  // Questa è una funzione complessa da implementare correttamente.
  // Per ora, un placeholder:
  console.warn(
    `La modifica del movimento ${id} non è completamente implementata e può avere effetti collaterali sulle giacenze.`
  );
  const { note } = req.body; // Permettiamo di modificare note e description
  if (note === undefined ) {
    return res
      .status(400)
      .json({
        success: false,
      message: "Nessun dato fornito per l'aggiornamento.",
      });
  }
  try {
        const [results] = await db.query('CALL UpdateMovimento(?, ?, ?)', [id, note]);
    if (results[0][0].affectedRows > 0) {
      res.json({ success: true, message: "Movimento aggiornato." });
    } else {
      res.status(404).json({ success: false, message: "Movimento non trovato." });
    }
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

  