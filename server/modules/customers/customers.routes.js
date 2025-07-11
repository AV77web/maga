// server/modules/customers/customers.routes.js
//=================================================
// Rotte Customers – v1
//=================================================
const express = require('express');
const router = express.Router();
const customersController = require('./customers.controller');
const validateSchema = require('../../middleware/validateSchema');
const customerSchema = require('../../schemas/customer.schema.json');

router.get('/', customersController.getCustomers);
router.post('/', validateSchema(customerSchema), customersController.insertCustomer);
router.put('/:id', validateSchema(customerSchema), customersController.updateCustomer);
router.delete('/:id', customersController.deleteCustomer);

module.exports = router; 