//c:\maga\server\middleware\errorHandler.js
//========================================
//File: erroeHandler.js
//Middleware per la gestine centralizzata
//degli errori.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-20"
//========================================

const logger = require('../utils/logger');

// Funzione per riconoscere errori specifici del database (es. MySQL)
function handleDatabaseError(err, res) {
  if (err.code) { // Codici errore specifici del DB
    switch (err.code) {
      case 'ER_DUP_ENTRY':
        return res.status(409).json({ success: false, message: 'Errore: Duplicato. La risorsa esiste già.', code: err.code });
      case 'ER_NO_REFERENCED_ROW_2':
        return res.status(400).json({ success: false, message: 'Errore: Riferimento a una risorsa inesistente (chiave esterna).', code: err.code });
      // Aggiungi altri codici errore DB specifici che vuoi gestire
      default:
        // Per altri errori DB non specificamente gestiti, potresti volerli trattare come errori generici del server
        logger.error('Unhandled Database Error Code:', err.code, err.message);
        return res.status(500).json({ success: false, message: 'Errore del database non gestito.', code: err.code });
    }
  }
  // Se non è un errore DB con codice noto, passa oltre
  return null;
}

// Riconosce errori di validazione Ajv inoltrati dal middleware validateSchema
function handleAjvValidationError(err, res) {
  if (err.validationErrors && Array.isArray(err.validationErrors)) {
    const formatted = err.validationErrors.map(e => ({
      field: e.instancePath || e.dataPath || '',
      message: e.message,
      keyword: e.keyword,
    }));
    return res.status(400).json({ success: false, errors: formatted });
  }
  return null;
}

const errorHandler = (err, req, res, next) => {
  logger.error("❌ ERRORE NON GESTITO:", err.stack || err);

  // Gestione errori Ajv
  const ajvResponse = handleAjvValidationError(err, res);
  if (ajvResponse) return;

  // Tenta di gestire errori specifici del database
  const dbErrorResponse = handleDatabaseError(err, res);
  if (dbErrorResponse) {
    return; // La risposta è già stata inviata da handleDatabaseError
  }

  // Gestione per errori con codice di stato definito (es. da validazioni o logica di business)
  if (err.statusCode) {
    return res.status(err.statusCode).json({
      success: false,
      message: err.message || 'Errore generico.',
      ...(process.env.NODE_ENV === 'development' && { stack: err.stack }) // Includi stack solo in sviluppo
    });
  }

  // Errore generico del server
  // In produzione, potresti voler loggare l'errore in modo più dettagliato
  // e restituire un messaggio generico all'utente.
  const statusCode = err.status || 500;
  const message = process.env.NODE_ENV === 'development' ? err.message : 'Errore interno del server.';

  res.status(statusCode).json({
    success: false,
    message: message,
    ...(process.env.NODE_ENV === 'development' && { stack: err.stack })
  });
};

module.exports = errorHandler;

