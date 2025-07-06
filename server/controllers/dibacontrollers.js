// ================================
//File: // controllers//dibacontrollers.js
//Script che crea i controller per le operazioni sulle diba
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const db = require("../db/db"); 


(async () => {
  try {
    // Test query per verificare la connessione al db
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database per diba OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per diba:", err.message);
  }
})();

// Funzione di validazione specifica per le DiBa
function validateDiBaInput(data, operation) {
  const { id_father, id_son, quantita } = data;
  if (!id_father || typeof id_father !== 'number') {
    return "Il campo 'id_father' è obbligatorio e deve essere un numero.";
  }
  if (!id_son || typeof id_son !== 'number') {
    return "Il campo 'id_son' è obbligatorio e deve essere un numero.";
  }
  if (!quantita || typeof quantita !== 'number') {
    return "Il campo 'quantita' è obbligatorio e deve essere un numero.";
  }

  if (operation === 'create' && data.id !== undefined) {
    return "L'ID non deve essere fornito durante la creazione.";
  }
  if (operation === 'update' && (data.id === undefined || isNaN(parseInt(data.id)))) {
    return "L'ID deve essere un numero valido durante l'aggiornamento.";
  }
  // Aggiungere altre validazioni se necessario
  return null; // Nessun errore
}

exports.getAllDiBa = async (req, res, next) => {
  try {
    const [results] = await db.query('CALL FetchDiba(NULL, NULL, NULL)');
    res.json({ success: true, data: results[0] });
  } catch (error) {
    next(error);
  }
};

exports.getDiBaById = async (req, res, next) => {
  const { id } = req.params;
  try {
    const [results] = await db.query('CALL FetchDiba(?, NULL, NULL)', [id]);
    if (results[0].length === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata.' });
    }
    res.json({ success: true, data: results[0][0] });
  } catch (error) {
    next(error);
  }
};

exports.insertDiBa = async (req, res, next) => {
  const validationError = validateDiBaInput(req.body, 'create');
  if (validationError) {
    return res.status(400).json({ success: false, message: validationError });
  }

  const { id_father, id_son, quantita } = req.body;
  try {
    const [results] = await db.query('CALL InsertDiba(?, ?, ?)', [id_father, id_son, quantita]);
    const insertId = results[0][0].insertId;
    res.status(201).json({ success: true, id: insertId, message: 'Riga distinta base creata con successo.' });
  } catch (error) {
    next(error);
  }
};

exports.updateDiBa = async (req, res, next) => {
  const { id } = req.params;
  const { quantita } = req.body;

  // Esegui una validazione parziale per l'aggiornamento
  if (quantita === undefined || typeof quantita !== 'number') {
    return res.status(400).json({ success: false, message: "Il campo 'quantita' è obbligatorio e deve essere un numero." });
  }

  try {
    const [results] = await db.query('CALL UpdateDiba(?, ?)', [id, quantita]);
    if (results[0][0].affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata per l\'aggiornamento.' });
    }
    res.json({ success: true, message: 'Riga distinta base aggiornata con successo.' });
  } catch (error) {
    next(error);
  }
};

exports.deleteDiBa = async (req, res, next) => {
  const { id } = req.params;
  try {
    const [results] = await db.query('CALL DeleteDiba(?)', [id]);
    if (results[0][0].affectedRows === 0) {
      return res.status(404).json({ success: false, message: 'Riga distinta base non trovata per l\'eliminazione.' });
    }
    res.json({ success: true, message: 'Riga distinta base eliminata con successo.' });
  } catch (error) {
    next(error);
  }
};

// Funzione per recuperare i componenti dell DiBa (Bill of Material);
exports.getBomByFatherId = async ( req, res, next) => {
  const fatherId = req.params.fatherId;
  console.log(`controllers/dibacontrollers.js: Richiesta distinta base per fatherId: ${fatherId}`);

  if (!fatherId) {
    return res.status(400).json({ success: false, message: "ID articolo padre mancante o non valido" })
  } 
  try {
    const [results] = await db.query('CALL FetchDiba(NULL, ?, NULL)', [fatherId]);
    res.json({ success: true, data: results[0] });
  } catch (error) {
    console.error(`❌ Errore nel recupero della distinta base per il padre ${fatherId}:`, error.message);
    next(error); // Passa l'errore al middleware centralizzato
  }
}