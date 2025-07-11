// server/modules/suppliers/suppliers.routes.js
//=================================================
// Rotte Suppliers – v1
//=================================================
const express = require('express');
const router = express.Router();
const suppliersController = require('./suppliers.controller');

router.get('/', suppliersController.getSuppliers);
router.post('/', suppliersController.insertSupplier);
router.put('/:id', suppliersController.updateSupplier);
router.delete('/:id', suppliersController.deleteSupplier);

module.exports = router; 