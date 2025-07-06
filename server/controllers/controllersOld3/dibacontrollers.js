// ================================
//File: // controllers//dibacontrollers.js
//Script che crea i controller per le operazioni sulle diba
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const { createCrudHandlers } = require('./crudHandlers');
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

//handler crud
const dibaCrudHandlers = createCrudHandlers('diba', { // Assumendo che la tabella si chiami 'diba'
  fieldsToSelect: 'id, id_father, id_son, quantita', // Adattare i campi se necessario
  validateInput: validateDiBaInput
});

exports.getAllDiBa = dibaCrudHandlers.getAll;
exports.getDiBaById = dibaCrudHandlers.getById;
exports.insertDiBa = dibaCrudHandlers.create;
exports.updateDiBa = dibaCrudHandlers.update;
exports.deleteDiBa = dibaCrudHandlers.delete;

// Correzione dell'errore di sintassi in updateDiBa originale, ora gestito da crudHandlers
// L'handler generico gestisce già il messaggio di successo.

// Funzione per recuperare i componenti dell DiBa (Bill of Material);
exports.getBomByFatherId = async ( req, res, next) => {
  const fatherId = req.params.fatherId;
  console.log(`controllers/dibacontrollers.js: Richiesta distinta base per fatherId: ${fatherId}`);

  if (!fatherId) {
    //Basic validation for the parameter
    return res.status(400).json({ success: false, message: "ID articolo padre mancante o non valido" })
  } 
  try {
    //Query the 'diba'  table to find all entries where id_father matches the requeste fatherID
      // Join with the 'articoli' table to get the name and description of the son article
      // Use aliases 'd' for diba and 'r' for articoli for clarity
    const query = "SELECT d.id, d.id_father, d.id_son, d.quantita, r.name AS son_name, r.description AS son_description FROM diba d JOIN articoli r ON d.id_son = r.id WHERE d.id_father = ?";
    const [row ] = await db.query(query, [fatherId]);
    res.json({ success: true, data: row }); // Send the results back. The frontend expects a 'data' array.
  } catch (error) {
    console.error(`❌ Errore nel recupero della distinta base per il padre ${fatherId}:`, error.message);
    next(error); // Passa l'errore al middleware centralizzato
  }
}