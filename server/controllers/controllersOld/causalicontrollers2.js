//==========================================
//File: // controllers//causalicontrollers.js
//Script che crea i controller per le operazioni sulle causali
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const db = require("../../db/db"); 

(async () => {
  try {
    // Test query per verificare la connessione
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database per causali OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per causali:", err.message);
  }
})();



// GET tutte le causali
exports.getCausali = async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM causali ORDER BY codice");
    res.json({ success: true, data: rows });
  } catch (error) {
    console.error("Errore nel recupero delle causali:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// POST: nuova causale
exports.insertCausale = async (req, res) => {
  const { codice, description, tipo } = req.body;
  if (!codice || description === undefined || tipo === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per la causale." });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO causali (codice, description, tipo) VALUES (?, ?, ?)",
      [codice, description, tipo]
    );
    res.status(201).json({ success: true, id: result.insertId, message: "Causale inserita con successo" });
  } catch (error) {
    console.error("Errore durante l'inserimento della causale:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// PUT: modifica causale
exports.updateCausale = async (req, res) => {
  const { id } = req.params;
  const { codice, description, tipo } = req.body;
  if (!codice || description === undefined || tipo === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per l'aggiornamento della causale." });
  }
  try {
    const [result] = await db.query(
      "UPDATE causali SET codice=?, description=?, tipo=? WHERE id=?",
      [codice, description, tipo, id]
    );
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Causale non trovata per l'aggiornamento." });
    }
    res.json({ success: true, message: "Causale aggiornata con successo" });
  } catch (error) {
    console.error("Errore durante l'aggiornamento della causale:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// DELETE: elimina causale
exports.deleteCausale = async (req, res) => {
  const { id } = req.params;
  try {
    const [result] = await db.query("DELETE FROM causali WHERE id=?", [id]);
    if (result.affectedRows === 0) {
      return res.status(404).json({ success: false, error: "Causale non trovata per l'eliminazione." });
    }
    res.json({ success: true, message: "Causale eliminata con successo" });
  } catch (error) {
    console.error("Errore durante l'eliminazione della causale:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};