//==================================================
//File: movimenticontrollers.js
//Script che crea il controller per le operazioni sui
//movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.1 2024-07-26" // Aggiornata versione e data
//==================================================
const db = require("../../db/db");
const { createCrudHandlers } = require('../crudHandlers');

const movimentiSpecificFields = 'm.id, m.data, m.quantita, a.name as descriptionart, c.description as descriptioncau, m.tipo, m.idart, m.idcau, m.note';
const movimentiJoins = 'FROM movimenti m JOIN articoli a ON m.idart = a.id JOIN causali c ON m.idcau = c.id';

const movimentoCrudHandlers = createCrudHandlers('movimenti', { fieldsToSelect: movimentiSpecificFields, baseQueryWithJoins: movimentiJoins });
// Nota: movimentoCrudHandlers è definito ma non utilizzato per le esportazioni CRUD sottostanti.
// Si potrebbe considerare di usarlo per semplificare il codice, ad es.:
// exports.getMovimenti = movimentoCrudHandlers.getAll;
// exports.getMovimentoById = movimentoCrudHandlers.getById;
// exports.insertMovimento = movimentoCrudHandlers.create;
// exports.updateMovimento = movimentoCrudHandlers.update;
// exports.deleteMovimento = movimentoCrudHandlers.delete;
// Questo richiederebbe che createCrudHandlers gestisca correttamente i campi specifici per l'insert/update
// e che la logica di join sia applicata correttamente anche per getById.

// Query personalizzata per eseguire un filtro dei dati database sulla tabella dataabase
exports.customQuery = async (req, res) => {
const {query} = req.body;

  if(!query || typeof query !== "string") {
    return res.status(400).json({ success: false, error: "Query mancanete o non valida."});
  }

  try {
    const [rows] = await db.query(query);
    res.json({ success: true, data: rows });
  } catch (error) {

    console.error("Errore nella query personalizzata:", error);
    res.status(500).json({success: false, error: error.message});
}
};

// GET tutti i movimenti con join specifici
exports.getMovimenti = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT ${movimentiSpecificFields}
      ${movimentiJoins}
      ORDER BY m.data DESC
    `);
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero dei movimenti:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// GET singolo movimento by ID con join specifici
exports.getMovimentoById = async (req, res) => {
  const { id } = req.params;
  try {
    const [rows] = await db.query(`
      SELECT ${movimentiSpecificFields}
      ${movimentiJoins}
      WHERE m.id = ?
    `, [id]);
    if (rows.length === 0) {
      return res.status(404).json({ success: false, error: "Movimento non trovato." });
    }
    res.json({ success: true, data: rows[0] });
  } catch (error) {
    console.error(`Errore nel recupero del movimento con ID ${id}:`, error);
    res.status(500).json({ success: false, error: error.message });
  }
};

 // POST: nuovo movimento
 exports.insertMovimento = async (req, res) => {
  const { data, quantita, tipo, idart, idcau, note } = req.body;

  // Validazione di base (puoi renderla più robusta)
  if (data === undefined || quantita === undefined || tipo === undefined || idart === undefined || idcau === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per il movimento." });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO movimenti (data, quantita, tipo, idart, idcau, note) VALUES (?, ?, ?, ?, ?, ?)",
      [data, quantita, tipo, idart, idcau, note === undefined ? null : note] // Gestisce 'note' opzionale
    );
    res.status(201).json({ success: true, id: result.insertId, message: "Movimento inserito con successo" });
  } catch (error) {
    console.error("Errore durante l'inserimento del movimento:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// PUT: modifica movimento
exports.updateMovimento = async (req, res) => {
  const { id } = req.params;
  const { data, quantita, tipo, idart, idcau, note } = req.body;

  if (data === undefined || quantita === undefined || tipo === undefined || idart === undefined || idcau === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per l'aggiornamento del movimento." });
  }

  try {
    const [result] = await db.query(
      "UPDATE movimenti SET data=?, quantita=?, tipo=?, idart=?, idcau=?, note=? WHERE id=?",
      [data, quantita, tipo, idart, idcau, note === undefined ? null : note, id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Movimento non trovato per l'aggiornamento." });
    }
    res.json({ success: true, message: "Movimento aggiornato con successo" });
  } catch (error) {
    console.error("Errore durante l'aggiornamento del movimento:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// DELETE: elimina movimento
exports.deleteMovimento = async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query("DELETE FROM movimenti WHERE id=?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Movimento non trovato per l'eliminazione." });
    }
    res.json({ success: true, message: "Movimento eliminato con successo" });
  } catch (error) {
    console.error("Errore durante l'eliminazione del movimento:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};
