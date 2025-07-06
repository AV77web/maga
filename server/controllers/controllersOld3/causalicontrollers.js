//==========================================
//File: // controllers//causalicontrollers.js
//Script che crea i controller per le operazioni sulle causali
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==========================================
const { createCrudHandlers } = require('./crudHandlers');
const db = require("../db/db");

(async () => {
  try {
    // Test query per verificare la connessione
    const [rows] = await db.query("SELECT 1 + 1 AS result");
    console.log("✅ Connessione al database per causali OK:", rows[0]);
  } catch (err) {
    console.error("❌ ERRORE connessione al DB per causali:", err);
  }
})();

// Funzione di validazione specifica per le causali
function validateCausaleInput(data, operation) {
  const { codice, description, tipo } = data;
  if (!codice || typeof codice !== 'string' || codice.trim() === '') {
    return "Il campo 'codice' è obbligatorio e deve essere una stringa.";
  }
  if (description === undefined || typeof description !== 'string') { // Permettiamo stringa vuota per description
    return "Il campo 'description' deve essere una stringa.";
  }
  if (!tipo || !['C', 'S', 'N'].includes(tipo.toUpperCase())) { // Esempio: Carico, Scarico, Neutro
    return "Il campo 'tipo' è obbligatorio e deve essere 'C', 'S', o 'N'.";
  }

  if (operation === 'create' && data.id !== undefined) {
    return "L'ID non deve essere fornito durante la creazione.";
  }
  if (operation === 'update' && (data.id === undefined || isNaN(parseInt(data.id)))) {
    return "L'ID deve essere un numero valido durante l'aggiornamento.";
  }
  return null; // Nessun errore
}

const causaliCrudHandlers = createCrudHandlers('causali', {
  fieldsToSelect: 'id, codice, description, tipo', // Specifica i campi se non vuoi '*'
  validateInput: validateCausaleInput,
});

exports.getCausali = causaliCrudHandlers.getAll;
exports.getCausaleById = causaliCrudHandlers.getById; // Aggiunto per coerenza
exports.insertCausale = causaliCrudHandlers.create;
exports.updateCausale = causaliCrudHandlers.update;
exports.deleteCausale = causaliCrudHandlers.delete;