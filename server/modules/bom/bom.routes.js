// server/modules/bom/bom.routes.js
//=================================================
// Rotte BOM – v1
//=================================================
const express = require('express');
const router = express.Router();
const bomController = require('./bom.controller');
const validateSchema = require('../../middleware/validateSchema');
const bomSchema = require('../../schemas/bom.schema.json');

router.get('/', bomController.getAllBom);
router.get('/father/:fatherId', bomController.getBomByFather);
router.post('/', validateSchema(bomSchema), bomController.insertBom);
router.put('/:id', validateSchema(bomSchema), bomController.updateBom);
router.delete('/:id', bomController.deleteBom);

module.exports = router; 