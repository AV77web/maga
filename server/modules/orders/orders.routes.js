// server/modules/orders/orders.routes.js
//=================================================
// Rotte Orders – v1
//=================================================
const express = require('express');
const router = express.Router();
const ordersController = require('./orders.controller');
const validateSchema = require('../../middleware/validateSchema');
const orderSchema = require('../../schemas/order.schema.json');

router.get('/', ordersController.getOrders);
router.get('/:id', ordersController.getOrderById);
router.get('/:orderId/items', ordersController.getOrderLines);
router.post('/', validateSchema(orderSchema), ordersController.insertOrder);
router.put('/:id_ordine', validateSchema(orderSchema), ordersController.updateOrder);
router.delete('/:id_ordine', ordersController.deleteOrder);

module.exports = router; 