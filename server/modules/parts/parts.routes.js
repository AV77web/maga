// server/modules/parts/parts.routes.js
//=================================================
// Rotte per Parts (ex Ricambi) – versione v1
//=================================================
const express = require('express');
const router = express.Router();
const partsController = require('./parts.controller');

// /api/v1/parts
router.get('/', partsController.getParts);
router.post('/', partsController.insertPart);
router.put('/:id', partsController.updatePart);
router.delete('/:id', partsController.deletePart);

module.exports = router; 