//=============================================
//File: server/utiles/ajv.js
//Scrip che definisce l'istanza di AJV per la 
//validazione dei dati in ingresso.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-11"
//==============================================

const Ajv = require("ajv/dist/2020");
const addFormats = require("ajv-formats");
const addErrors = require("ajv-errors");

// Shared AJV instance configured for application-wide validation.
// - allErrors: collect every validation error to return complete feedback
// - removeAdditional: strip properties not present in the schema (security & cleanliness)
// - coerceTypes: convert primitive types when reasonable (e.g. "123" -> 123)
// You can optionally disable strict mode warnings by adding { strict: false }
const ajv = new Ajv({
  allErrors: true,
  removeAdditional: "all",
  coerceTypes: true,
});

// Add standard string/number/date formats (email, uuid, date-time, ...)
addFormats(ajv);

// Provide better error messages using the ajv-errors plugin
addErrors(ajv);

module.exports = ajv;
