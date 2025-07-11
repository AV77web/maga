// server/modules/orders/orders.routes.js
//=================================================
// Rotte Orders – v1
//=================================================
const express = require('express');
const router = express.Router();
const ordersController = require('./orders.controller');

router.get('/', ordersController.getOrders);
router.get('/:orderId/items', ordersController.getOrderLines);
router.post('/', ordersController.insertOrder);
router.put('/:id_ordine', ordersController.updateOrder);
router.delete('/:id_ordine', ordersController.deleteOrder);

module.exports = router; 