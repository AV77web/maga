// server/modules/counterparties/counterparties.routes.js
//=================================================
// Rotte per Counterparties – versione v1
//=================================================
const express = require('express');
const router = express.Router();
const counterpartiesController = require('./counterparties.controller');
const validateSchema = require('../../middleware/validateSchema');
// TODO: definire uno schema JSON valido per controparte
let counterpartySchema;
try {
  counterpartySchema = require('../../schemas/counterparty.schema.json');
} catch (err) {
  // Se lo schema non esiste ancora, logga un warning ma continua senza validazione
  console.warn('⚠️  counterparty.schema.json non trovato, skip validateSchema');
}

router.get('/', counterpartiesController.getCounterparties);
router.post('/', counterpartySchema ? validateSchema(counterpartySchema) : (req, _res, next) => next(), counterpartiesController.insertCounterparty);
router.put('/:id', counterpartySchema ? validateSchema(counterpartySchema) : (req, _res, next) => next(), counterpartiesController.updateCounterparty);
router.delete('/:id', counterpartiesController.deleteCounterparty);

module.exports = router; 