//==================================================
//File: // controllers//movimenticontrollers.js
//Script che crea i controller per le operazioni sui movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================================
const db = require("../db/db");
const mytimestamp = require("../timestamp");
const { createCrudHandlers } = require("./crudHandlers");
const logger = require("../utils/logger");
logger.info("Caricamento movimenticontrollers.js con filtri");

// PATCH AVANZATA: Sicurezza massima su customQuery
exports.customQuery = async (req, res, next) => {
  const { query } = req.body;
  const allowedTables = {
    articoli: ["id", "nome", "descrizione", "prezzo"],
    clienti: ["id", "nome", "email"],
    fornitori: ["id", "nome", "contatto"],
    movimenti: ["id", "idart", "quantita", "data"],
    login: ["id", "user", "role"],
    // aggiungi qui le colonne consentite per ogni tabella
  };
  const MAX_LIMIT = 100;

  if (!query || typeof query !== "string") {
    return res
      .status(400)
      .json({ success: false, error: "Query mancante o non valida." });
  }

  // Blocca commenti SQL
  if (/--|#|\/\*|\*\//.test(query)) {
    return res
      .status(403)
      .json({ success: false, error: "Commenti SQL non consentiti." });
  }

  // Solo SELECT semplice, no join, no union, no subquery, no comandi multipli
  if (
    !/^select\s+.+\s+from\s+\w+(\s+where\s+.+)?(\s+limit\s+\d+)?\s*$/i.test(
      query.trim()
    )
  ) {
    return res
      .status(403)
      .json({
        success: false,
        error:
          "Solo SELECT semplici consentite (no join, no union, no subquery, no comandi multipli).",
      });
  }

  // Estrai colonne e tabella
  const match = query.match(/^select\s+(.+)\s+from\s+(\w+)/i);
  if (!match) {
    return res
      .status(403)
      .json({ success: false, error: "Formato query non valido." });
  }
  const columns = match[1].split(",").map((c) => c.trim().replace(/`/g, ""));
  const table = match[2].toLowerCase();

  if (!Object.keys(allowedTables).includes(table)) {
    return res
      .status(403)
      .json({ success: false, error: "Tabella non consentita." });
  }

  // Blocca SELECT *
  if (columns.length === 1 && columns[0] === "*") {
    return res
      .status(403)
      .json({
        success: false,
        error: "SELECT * non consentito. Specifica le colonne.",
      });
  }

  // Limita le colonne
  if (!columns.every((col) => allowedTables[table].includes(col))) {
    return res
      .status(403)
      .json({ success: false, error: "Colonna non consentita." });
  }

  // Obbliga WHERE
  if (!/where\s+.+/i.test(query)) {
    return res
      .status(403)
      .json({
        success: false,
        error: "È obbligatorio specificare una clausola WHERE.",
      });
  }

  // Applica LIMIT massimo se non presente
  let safeQuery = query;
  if (!/limit\s+\d+/i.test(query)) {
    safeQuery = query.trim() + ` LIMIT ${MAX_LIMIT}`;
  }

  // Logga la query e l'utente (se disponibile)
  if (req.user) {
    logger.warn(
      { user: req.user, query: safeQuery },
      "Admin customQuery eseguita"
    );
  } else {
    logger.warn(
      { query: safeQuery },
      "customQuery eseguita senza user associato"
    );
  }

  try {
    const [rows] = await db.query(safeQuery);
    res.json({ success: true, data: rows });
  } catch (error) {
    next(error);
  }
};

// GET tutti i movimenti (potresti voler aggiungere filtri, es. per articolo o data)
// Modificato per gestire i filtri da req.query
exports.getMovimenti = async (req, res, next) => {
  try {
    const { idart, codice_cau, tipo, dataDa, dataA, user } = req.query;

    // Chiama la stored procedure con i parametri, passando null se non presenti
    const [rows] = await db.query("CALL FetchMovimenti(?, ?, ?, ?, ?,?)", [
      idart || null,
      dataDa || null,
      dataA || null,
      tipo || null,
      codice_cau || null,
      user || null,
    ]);
    logger.debug({ rows: rows[0].length }, "Rows returned FetchMovimenti");
    res.json({ success: true, data: rows[0] });
    //console.log(rows[0]);
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// POST: nuovo movimento
exports.insertMovimento = async (req, res, next) => {
  const timestamp = mytimestamp().trim();
  const { idart, codice_cau, data, quantita, tipo, note, user } = req.body;

  try {
    const [results] = await db.query(
      "CALL Insert_Movimento(?, ?, ?, ?, ?, ?, ? ,? )",
      [idart, codice_cau, data, quantita, tipo, note, user, timestamp || null]
    );

    const insertId = results[0][0].insertId;

    res.status(201).json({
      success: true,
      id: insertId,
      message: "Movimento registrato e articolo aggiornato.",
    });
  } catch (error) {
    next(error);
  }
};

// PUT: modifica movimento (ATTENZIONE: modificare un movimento può essere complesso)
// La modifica di un movimento spesso implica stornare il vecchio movimento e crearne uno nuovo,
// o ricalcolare le giacenze. Questa è una semplificazione.
exports.updateMovimento = async (req, res, next) => {
  const { id } = req.params;
  // Considera quali campi di un movimento possono essere modificati e l'impatto sulle giacenze.
  // Questa è una funzione complessa da implementare correttamente.
  // Per ora, un placeholder:
  console.warn(
    `La modifica del movimento ${id} non è completamente implementata e può avere effetti collaterali sulle giacenze.`
  );
  const { note } = req.body; // Permettiamo di modificare note e description
  if (note === undefined) {
    return res.status(400).json({
      success: false,
      message: "Nessun dato fornito per l'aggiornamento.",
    });
  }
  try {
    const [results] = await db.query("CALL UpdateMovimento(?, ?, ?)", [
      id,
      note,
    ]);
    if (results[0][0].affectedRows > 0) {
      res.json({ success: true, message: "Movimento aggiornato." });
    } else {
      res
        .status(404)
        .json({ success: false, message: "Movimento non trovato." });
    }
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};
