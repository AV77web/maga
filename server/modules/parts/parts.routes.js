// server/modules/parts/parts.routes.js
//=================================================
// Rotte per Parts (ex Ricambi) – versione v1
//=================================================
const express = require('express');
const router = express.Router();
const partsController = require('./parts.controller');
const validateSchema = require('../../middleware/validateSchema');
const partSchema = require('../../schemas/part.schema.json');

// /api/v1/parts
router.get('/', partsController.getParts);
router.post('/', validateSchema(partSchema), partsController.insertPart);
router.put('/:id', validateSchema(partSchema), partsController.updatePart);
router.delete('/:id', partsController.deletePart);

module.exports = router; 