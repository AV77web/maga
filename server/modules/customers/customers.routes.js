// server/modules/customers/customers.routes.js
//=================================================
// Rotte Customers – v1
//=================================================
const express = require('express');
const router = express.Router();
const customersController = require('./customers.controller');

router.get('/', customersController.getCustomers);
router.post('/', customersController.insertCustomer);
router.put('/:id', customersController.updateCustomer);
router.delete('/:id', customersController.deleteCustomer);

module.exports = router; 