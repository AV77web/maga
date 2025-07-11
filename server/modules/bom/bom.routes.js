// server/modules/bom/bom.routes.js
//=================================================
// Rotte BOM – v1
//=================================================
const express = require('express');
const router = express.Router();
const bomController = require('./bom.controller');

router.get('/', bomController.getAllBom);
router.get('/father/:fatherId', bomController.getBomByFather);
router.post('/', bomController.insertBom);
router.put('/:id', bomController.updateBom);
router.delete('/:id', bomController.deleteBom);

module.exports = router; 