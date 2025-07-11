// server/utils/logger.js
//=================================================
// File: logger.js
// Wrapper centralizzato per pino
// - In development usa pino-pretty per output leggibile
// - In production output JSON per log aggregator
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-11"
//=================================================
const pino = require('pino');

// Abilita pretty-print solo in ambienti non-production
const isProd = process.env.NODE_ENV === 'production';

// Transport opzionale per pino-pretty
let transport = undefined;
if (!isProd) {
  try {
    transport = pino.transport({
      target: 'pino-pretty',
      options: {
        colorize: true,
        translateTime: 'HH:MM:ss.l',
        ignore: 'pid,hostname',
      },
    });
  } catch (err) {
    // In caso pino-pretty non sia installato correttamente
    // ricadi sul logger standard per evitare crash.
    console.error('Impossibile inizializzare pino-pretty:', err.message);
  }
}

const logger = pino(
  {
    level: process.env.LOG_LEVEL || 'info',
    redact: ['password', 'authorization', 'token'], // Evita di loggare dati sensibili
  },
  transport
);

module.exports = logger; 