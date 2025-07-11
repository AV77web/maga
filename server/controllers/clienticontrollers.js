//==========================================
//File: // controllers/clienticontrollers.js
//Script che crea i controller per le operazioni sui clienti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-08"
//==========================================
const db = require("../db/db");
const logger = require("../utils/logger");

// Funzione di validazione specifica per i clienti
function validateClienteInput(data) {
  const { codice, nome, tipo_cliente, partita_iva, cf } = data;

  if (!codice || !nome) {
    return "Codice e Nome sono campi obbligatori.";
  }
  if (typeof codice !== "string" || codice.trim() === "") {
    return "Il Codice non può essere vuoto.";
  }
  if (typeof nome !== "string" || nome.trim() === "") {
    return "Il Nome non può essere vuoto.";
  }

  if (tipo_cliente === 'Azienda' && (!partita_iva || partita_iva.trim() === '')) {
    return "La Partita IVA è obbligatoria per le aziende.";
  }
  if (tipo_cliente === 'Privato' && (!cf || cf.trim() === '')) {
    return "Il Codice Fiscale è obbligatorio per i privati.";
  }

  return null; // Nessun errore
}

// GET tutti i clienti, con gestione dei filtri
exports.getClienti = async (req, res, next) => {
  try {
    // Estrai i possibili filtri da req.query
    const { codice, nome, tipo_cliente, partita_iva, cf, citta, contatto, email} = req.query;

    // Prepara i parametri per la stored procedure. Se un filtro non è presente, passa NULL.
    const p_codice = codice || null;
    const p_nome = nome || null;
    const p_tipo_cliente = tipo_cliente || null;
    const p_partita_iva = partita_iva || null;
    const p_cf = cf || null;
    const p_citta = citta || null;
    const p_contatto = contatto || null;
    const p_email = email || null;

    logger.debug({ p_codice, p_nome, p_tipo_cliente }, "Call FetchClienti");

    // Chiama la stored procedure con i parametri (ipotizzando il nome FetchClienti)
    const [results] = await db.query("CALL FetchClienti(?,?,?,?,?,?,?,?)", [
      p_codice,
      p_nome,
      p_tipo_cliente,
      p_partita_iva,
      p_cf,
      p_citta,
      p_contatto,
      p_email
    ]);

    const rows = results[0];

    logger.debug({ rows: rows.length }, "Rows returned FetchClienti");
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero dei clienti:", error.message);
    next(error);
  }
};

// GET un cliente by ID
exports.getClienteById = async (req, res, next) => {
    try {
        const { id } = req.params;
        // Ipotizzando il nome FetchClienteById
        const [results] = await db.query("CALL FetchClienteById(?)", [id]);
        const cliente = results[0][0];

        if (!cliente) {
            return res.status(404).json({ success: false, error: "Cliente non trovato." });
        }

        res.json({ success: true, data: cliente });
    } catch (error) {
        console.error(`Errore nel recupero del cliente con ID ${req.params.id}:`, error.message);
        next(error);
    }
};

// POST - Inserisce un nuovo cliente usando la Stored Procedure InsertCliente
exports.insertCliente = async (req, res, next) => {
  try {
    const validationError = validateClienteInput(req.body);
    if (validationError) {
      return res.status(400).json({ success: false, error: validationError });
    }

    const {
      codice, nome, tipo_cliente, partita_iva, cf, indirizzo, citta,
      cap, pv, nazione, telefono, email, sito_web, note, contatto,
    } = req.body;

    // Ipotizzando il nome InsertCliente
    const [results] = await db.query(
      "CALL InsertCliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",
      [
        codice, nome, tipo_cliente, partita_iva, cf, indirizzo, citta,
        cap, pv, nazione, telefono, email, sito_web, note, contatto,
      ]
    );

    const newId = results[0][0].id;

    res.status(201).json({
      success: true,
      id: newId,
      message: "Cliente creato con successo.",
    });
  } catch (error) {
    console.error("Errore nell'inserimento del cliente:", error.message);
    next(error);
  }
};

// PUT - Modifica un cliente esistente usando la Stored Procedure UpdateCliente
exports.updateCliente = async (req, res, next) => {
  try {
    const { id } = req.params;
    const validationError = validateClienteInput(req.body);
    if (validationError) {
      return res.status(400).json({ success: false, error: validationError });
    }

    const {
      codice, nome, tipo_cliente, partita_iva, cf, indirizzo, citta,
      cap, pv, nazione, telefono, email, sito_web, note, contatto,
    } = req.body;

    // Ipotizzando il nome UpdateCliente
    await db.query("CALL UpdateCliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)", [
      id, codice, nome, tipo_cliente, partita_iva, cf, indirizzo, citta,
      cap, pv, nazione, telefono, email, sito_web, note, contatto,
    ]);

    res.json({ success: true, message: "Cliente aggiornato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'aggiornamento del cliente con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};

// DELETE - Elimina un cliente usando la Stored Procedure DeleteCliente
exports.deleteCliente = async (req, res, next) => {
  try {
    const { id } = req.params;
    // Ipotizzando il nome DeleteCliente
    await db.query("CALL DeleteCliente(?)", [id]);
    res.json({ success: true, message: "Cliente eliminato con successo." });
  } catch (error) {
    console.error(
      `Errore nell'eliminazione del cliente con ID ${req.params.id}:`,
      error.message
    );
    next(error);
  }
};