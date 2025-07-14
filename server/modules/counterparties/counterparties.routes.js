// server/modules/counterparties/counterparties.routes.js
//=================================================
// Rotte per Counterparties – versione v1
//=================================================
const express = require('express');
const router = express.Router();
const counterpartiesController = require('./counterparties.controller');
const validateSchema = require('../../middleware/validateSchema');
const counterpartySchema = require('../../schemas/counterparty.schema.json');

router.get('/', counterpartiesController.getCounterparties);
router.post('/', validateSchema(counterpartySchema), counterpartiesController.insertCounterparty);
router.put('/:id', validateSchema(counterpartySchema), counterpartiesController.updateCounterparty);
router.delete('/:id', counterpartiesController.deleteCounterparty);

module.exports = router; 