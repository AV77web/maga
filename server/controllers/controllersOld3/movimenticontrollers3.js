//==================================================
//File: // controllers//movimenticontrollers.js
//Script che crea i controller per le operazioni sui movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================================
const db = require("../db/db");
console.log("LOG SERVER: Caricamento di movimenticontrollers.js (quello con la 's' e i filtri)..."); // <-- NUOVO LOG

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
    const { idart, idcau, tipo, dataDa, dataA } = req.query;    
    // Rimosso il blocco if (conditions.length > 0) errato da qui
    let sql = `
      SELECT
        m.id, 
        m.data, 
        m.quantita, 
        a.name as descriptionart, 
        c.description as descriptioncau,
        m.tipo,
        m.idart,
        m.idcau,
        m.note
      FROM movimenti m
      JOIN articoli a ON m.idart = a.id
      JOIN causali c ON m.idcau = c.id
    `;

    const conditions = [];
    const queryParams = [];

    if (idart) {
      conditions.push("m.idart = ?");
      queryParams.push(idart);
    }
    if (idcau) {
      conditions.push("m.idcau = ?");
      queryParams.push(idcau);
    }
    if (tipo) {
      conditions.push("m.tipo = ?");
      queryParams.push(tipo);
    }
    if (dataDa) {
      conditions.push("m.data >= ?");
      queryParams.push(dataDa);
    }
    if (dataA) {
      conditions.push("m.data <= ?");
      queryParams.push(dataA);
    }

    if (conditions.length > 0) {
      sql += " WHERE " + conditions.join(" AND ");
    }

    sql += " ORDER BY m.data DESC";
    
    console.log('BACKEND: SQL Eseguita:', sql); // Log della query SQL
    console.log('BACKEND: Parametri SQL:', queryParams); // Log dei parametri per la query
    res.json({ success: true, data: rows });
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// POST: nuovo movimento
exports.insertMovimento = async (req, res, next ) => {
  // Esempio di campi per un movimento. Adattali!
  const {
    idart,
    idcau,
    data,
    quantita,
    tipo,
    note,
  } = req.body;

  // Controllo dei campi obbligatori (esempio)
  if (
    idart === undefined ||
    idcau === undefined ||
    data === undefined ||
    quantita === undefined ||
    !tipo
  ) {
    return res
      .status(400)
      .json({ success: false, error: "Dati movimento mancanti o incompleti" });
  }
  if (!['C','S'].includes(tipo)) {
    return res.status(400),json({
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

  let connection;
  try {
    connection = await db.getConnection(); // Ottieni una connessione per la transazione
    await connection.beginTransaction(); // Inizia la transazione

    // 1. Inserisci il movimento
    const [resultMovimento] = await connection.query(
      "INSERT INTO movimenti (idart, idcau, data, quantita, tipo, note) VALUES (?, ?, ?, ?, ?, ?)",
      [
        idart,
        idcau,
        data,
        quantita,
        tipo,
        note || null,
      ]
    );

    // 2. Aggiorna la quantità dell'articolo (logica di business)
    let queryAggiornamentoArticolo;
    if (tipo === "C") {
      // Assumendo che 'tipo' possa essere 'carico' o 'scarico'
      queryAggiornamentoArticolo =
        "UPDATE articoli SET quantita = quantita + ? WHERE id = ?";
    } else if (tipo === "S") {
      // Potresti voler aggiungere un controllo per assicurarti che la quantità non diventi negativa
      const [articoloAttuale] = await connection.query(
        "SELECT quantita FROM articoli WHERE id = ?",
        [idart]
      );
      if (
        articoloAttuale.length === 0 ||
        articoloAttuale[0].quantita < quantita
      ) {
        await connection.rollback(); // Annulla la transazione
        // Invece di restituire direttamente, crea un errore e passalo a next
        const err = new Error("Quantità insufficiente per lo scarico.");
        err.statusCode = 400; // Aggiungi statusCode per errorHandler
        return next(err);
      }
      queryAggiornamentoArticolo =
        "UPDATE articoli SET quantita = quantita - ? WHERE id = ?";
    } else {
      await connection.rollback();
      return res
        .status(400)
        .json({ success: false, messagge: "Tipo movimento non valido." });
    }

    await connection.query(queryAggiornamentoArticolo, [
      quantita,
      idart,
    ]);

    await connection.commit(); // Conferma la transazione

    res
      .status(201)
      .json({
        success: true,
        id: resultMovimento.insertId,
        message: "Movimento registrato e articolo aggiornato.",
      });
  } catch (error) {
    if (connection) await connection.rollback(); // Annulla la transazione in caso di errore    
    next(error); // Passa l'errore al middleware centralizzato
  } finally {
    if (connection) connection.release(); // Rilascia la connessione al pool
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
  const { note } = req.body; // Esempio: permettiamo solo di modificare le note
  if (note === undefined) {
    return res
      .status(400)
      .json({
        success: false,
        message:
          "Nessun dato fornito per l'aggiornamento o campo non modificabile.",
      });
  }
  try {
    await db.query("UPDATE movimenti SET note=? WHERE id=?", [note, id]);
    res.json({ success: true, message: "Nota movimento aggiornata." });
  } catch (error) {
    next(error); // Passa l'errore al middleware centralizzato
  }
};

// DELETE: elimina movimento (ATTENZIONE: eliminare un movimento richiede di stornare l'effetto sulla giacenza)
// Questa è una semplificazione.
exports.deleteMovimento = async (req, res,next) => {
  const { id } = req.params;
  let connection;
  try {
    connection = await db.getConnection();
    await connection.beginTransaction();

    // 1. Ottieni i dettagli del movimento da eliminare per stornare la quantità
    const [movimentoDaEliminareRows] = await connection.query(
      "SELECT idart, quantita, tipo FROM movimenti WHERE id = ?",
      [id]
    );
    if (movimentoDaEliminareRows.length === 0) {
      await connection.rollback();
      const err = new Error("Movimento non trovato.");
      err.statusCode = 404;
      return next(err);
    }
    const movimentoDaEliminare = movimentoDaEliminareRows[0];

    // 2. Storna l'effetto sulla quantità dell'articolo
    let queryStornoArticolo;
    if (movimentoDaEliminare.tipo === "C") {
      // Se era un carico, ora devo scaricare (sottrarre)
      queryStornoArticolo =
        "UPDATE articoli SET quantita = quantita - ? WHERE id = ?";
    } else if (movimentoDaEliminare.tipo === "S") {
      // Se era uno scarico, ora devo caricare (aggiungere)
      queryStornoArticolo =
        "UPDATE articoli SET quantita = quantita + ? WHERE id = ?";
    } else {
      await connection.rollback();
      const err = new Error("Tipo movimento del record da eliminare non valido.");
      err.statusCode = 400;
      return next(err);
    }
    await connection.query(queryStornoArticolo, [
      movimentoDaEliminare.quantita,
      movimentoDaEliminare.idart,
    ]);

    // 3. Elimina il movimento
    await connection.query("DELETE FROM movimenti WHERE id=?", [id]);

    await connection.commit();
    res.json({
      success: true,
      message: "Movimento eliminato e giacenza articolo aggiornata.",
    });
  } catch (error) {
        if (connection) await connection.rollback();    
    next(error); // Passa l'errore al middleware centralizzato
  } finally {
    if (connection) connection.release();
  }
};
