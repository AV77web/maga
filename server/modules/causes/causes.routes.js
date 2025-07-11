// server/modules/causes/causes.routes.js
//=================================================
// Rotte Causes – v1
//=================================================
const express = require('express');
const router = express.Router();
const causesController = require('./causes.controller');

router.get('/', causesController.getCauses);
router.post('/', causesController.insertCause);
// PUT/DELETE non implementati – prevista futura estensione

module.exports = router; 