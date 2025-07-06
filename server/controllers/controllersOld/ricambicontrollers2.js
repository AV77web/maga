//==========================================
//File: // controllers//ricambiController.js
//Script che crea i controller per le operazioni sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//==========================================
const db = require("../../db/db");

(async () => {
  try {
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB:", err.message);
  }
})();

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
  const { name, description, quantita, min, max, supplier } = req.body;
  // Controllo dei campi obbligatori (supplier potrebbe essere opzionale a seconda della definizione del DB)
  if (!name || description === undefined || quantita === undefined || min === undefined || max === undefined || supplier === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per il ricambio." });
  }

  try {
    const [result] = await db.query(
      "INSERT INTO articoli (name, description, quantita, min, max, supplier) VALUES (?, ?, ?, ?, ?, ?)",
      [name, description, quantita, min, max, supplier]
    );
    res.status(201).json({ success: true, id: result.insertId, message: "Ricambio inserito con successo" });
  } catch (error) {
    console.error("Errore durante l'inserimento del ricambio:", error);
    res.status(500).json({ success: false, error: error.message });
  }
};

// PUT: modifica ricambio
exports.updateRicambio = async (req, res) => {
  const { id } = req.params;
  const { name, description, quantita, min, max, supplier} = req.body;
  if (!name || description === undefined || quantita === undefined || min === undefined || max === undefined || supplier === undefined) {
    return res.status(400).json({ success: false, error: "Dati mancanti o incompleti per l'aggiornamento del ricambio." });
  }
  try {
    await db.query(
      "UPDATE articoli SET name=?, description=?, quantita=?, min=?, max=?, supplier=? WHERE id=?",
      [name, description, quantita, min, max, supplier,id]
    );
    res.json({ success: true, message: "Ricambio aggiornato con successo" });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};

// DELETE: elimina ricambio
exports.deleteRicambio = async (req, res) => {
  const { id } = req.params;
  try {
    await db.query("DELETE FROM articoli WHERE id=?", [id]);
    res.json({ success: true, message: "Ricambio eliminato con successo" });
  } catch (error) {
    res.status(500).json({ success: false, error: error.message });
  }
};
