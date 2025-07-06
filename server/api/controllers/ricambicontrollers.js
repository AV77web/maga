//==========================================
//File: // controllers//ricambiController.js
//Script che crea i controller per le operazioni sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//==========================================
const db = require("../db/db");

// GET tutti i ricambi
exports.getRicambi = async (req, res) => {
  try {
    const [rows] = await db.query("SELECT * FROM articoli");
    res.json({ success: true, data: rows });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

// POST: nuovo ricambio
exports.insertRicambio = async (req, res) => {
  const { name, description, quantita, min, max } = req.body;
  // Controllo dei campi obbligatori
  if (!name || !description || !quantita || !min || !max) {
    return res.status(400).json({ success: false, error: "Dati mancanti" });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO articoli (name, description, quantita, min, max) VALUES (?, ?, ?, ?, ?)",
      [name, description, quantita, min, max]
    );
    res.json({ success: true, id: result.insertId });
  } catch (error) {
    console.error("Errore durante l'inserimento,error");
    res.status(500).json({ success: false, error: error.message });
  }
};

// PUT: modifica ricambio
exports.updateRicambio = async (req, res) => {
  const { id } = req.params;
  const { name, description, quantita, min, max } = req.body;
  try {
    await db.query(
      "UPDATE articoli SET name=?, description=?, quantita=?, min=?, max=? WHERE id=?",
      [name, description, quantita, min, max, id]
    );
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

// DELETE: elimina ricambio
exports.deleteRicambio = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query("DELETE FROM articoli WHERE id=?", [id]);
    res.json({ success: true });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
