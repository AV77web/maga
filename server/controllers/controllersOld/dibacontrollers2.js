
// ================================
//File: controllers/dibacontrollers.js // Corretto riferimento nel commento
//Script che crea i controller per le operazioni sulle diba
//@author: "villari.andrea@libero.it"
//@version: "1.0.1 2024-07-26" // Aggiornata versione e data
//==========================================
const db = require("../../db/db"); 

(async () => {
  try {
    // Test query per verificare la connessione
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database per diba OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per diba:", err.message);
  }
})();

// GET: tutte le DiBa (Distinte Base)
exports.getDiba = async (req, res) => {
  try {
    const [rows] = await db.query(`
      SELECT *
      FROM diba
      ORDER BY codice ASC 
    `);
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero delle Distinte Base:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// POST: nuova DiBa
exports.insertDiba = async (req, res) => { // Nome funzione corretto per coerenza
  const { codice, description, tipo } = req.body;
  if (!codice || description === undefined || tipo === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per la DiBa." });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO diba (codice, description, tipo) VALUES (?, ?, ?)",
      [codice, description, tipo]
    );
    res.status(201).json({ success: true, id: result.insertId, message: "DiBa inserita con successo" });
  } catch (error) {
    console.error("Errore durante l'inserimento della Distinta Base:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// PUT: modifica DiBa
exports.updateDiba = async (req, res) => { // Nome funzione corretto per coerenza
  const { id } = req.params;
  const { codice, description, tipo } = req.body;
  if (!codice || description === undefined || tipo === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per l'aggiornamento della DiBa." });
  }
  try {
    const [result] = await db.query(
      "UPDATE diba SET codice=?, description=?, tipo=? WHERE id=?",
      [codice, description, tipo, id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Distinta Base non trovata per l'aggiornamento." });
    }
    res.json({ success: true, message: "Distinta Base aggiornata con successo" });
  } catch (error) {
    console.error("Errore durante l'aggiornamento della Distinta Base:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// DELETE: elimina DiBa
exports.deleteDiba = async (req, res) => { // Nome funzione corretto per coerenza
  const { id } = req.params;
  try {
    const [result] = await db.query("DELETE FROM diba WHERE id=?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Distinta Base non trovata per l'eliminazione." });
    }
    res.json({ success: true, message: "Distinta Base eliminata con successo" });
  } catch (error) {
    console.error("Errore durante l'eliminazione della Distinta Base:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};