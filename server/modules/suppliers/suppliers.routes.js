// server/modules/suppliers/suppliers.routes.js
//=================================================
// Rotte Suppliers – v1
//=================================================
const express = require('express');
const router = express.Router();
const suppliersController = require('./suppliers.controller');
const validateSchema = require('../../middleware/validateSchema');
const supplierSchema = require('../../schemas/supplier.schema.json');

router.get('/', suppliersController.getSuppliers);
router.post('/', validateSchema(supplierSchema), suppliersController.insertSupplier);
router.put('/:id', validateSchema(supplierSchema), suppliersController.updateSupplier);
router.delete('/:id', suppliersController.deleteSupplier);

module.exports = router; 