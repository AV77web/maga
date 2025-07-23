// server/modules/orders/orders.routes.js
//=================================================
// Rotte Orders – v1
//=================================================
const express = require('express');
const router = express.Router();
const ordersController = require('./orders.controller');
const validateSchema = require('../../middleware/validateSchema');
const orderSchema = require('../../schemas/order.schema.json');
const orderLinesController = require('../orderlines/orderlines.controller');


router.get('/', ordersController.getOrders);
router.get('/:id', ordersController.getOrderById);
router.get('/:id/items', (req, res, next) => {
  //console.log('ROUTE /api/v1/orders/:id/items HIT, req.params:', req.params);
  orderLinesController.getOrdineRighe(req, res, next);
});
router.post('/', validateSchema(orderSchema), ordersController.insertOrder);
router.put('/:id_ordine', validateSchema(orderSchema), ordersController.updateOrder);
router.delete('/:id_ordine', ordersController.deleteOrder);

module.exports = router; 