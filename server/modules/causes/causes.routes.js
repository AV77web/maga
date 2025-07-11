// server/modules/causes/causes.routes.js
//=================================================
// Rotte Causes – v1
//=================================================
const express = require('express');
const router = express.Router();
const causesController = require('./causes.controller');
const validateSchema = require('../../middleware/validateSchema');
const causeSchema = require('../../schemas/cause.schema.json');

router.get('/', causesController.getCauses);
router.post('/', validateSchema(causeSchema), causesController.insertCause);
// PUT/DELETE non implementati – prevista futura estensione

module.exports = router; 