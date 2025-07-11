//========================================================
//File: server/middleware/validateSchema.js
//Script che definisce il middleware per validare req.body
//(e in futuro anche req.params e req.query)
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-11"
// =======================================================

const ajv = require("../utils/ajv");
const logger = require('../utils/logger');

/**
 * Restituisce un middleware Express che valida req[property] (default: body)
 * contro lo schema JSON Schema fornito. In caso di errori risponde 400 con
 * la lista degli errori Ajv, altrimenti passa al next middleware.
 *
 * @param {object} schema - JSON Schema v2020-12 (plain object)
 * @param {('body'|'params'|'query'|'headers')} [property='body'] - Fonte da validare
 */
function validateSchema(schema, property = "body") {
  // Pre-compiliamo una sola volta per efficienza
  const validate = ajv.compile(schema);

  return (req, res, next) => {
    const data = req[property];
    const valid = validate(data);

    if (!valid) {
      logger.debug({ errors: validate.errors, data }, 'Payload non valido');
      const error = new Error('ValidationError');
      error.statusCode = 400;
      error.validationErrors = validate.errors;
      return next(error);
    }

    return next();
  };
}

module.exports = validateSchema; 