// ===============================================
// File: orderlines.routes.js
// Rotte per la gestione delle righe ordine
// ===============================================
const express = require('express');
const router = express.Router();
const validateSchema = require('../../middleware/validateSchema');
const orderLineSchema = require('../../schemas/orderline.schema.json');
const orderLinesCtrl = require('../../controllers/ordinilinecontrollers');

// GET tutte le righe di un ordine
router.get('/orders/:orderId/lines', orderLinesCtrl.getOrderLines);

// POST nuova riga ordine
router.post('/orders/:orderId/lines', validateSchema(orderLineSchema), orderLinesCtrl.insertOrderLine);

// PUT aggiorna riga ordine
router.put('/order-lines/:id', validateSchema(orderLineSchema), orderLinesCtrl.updateOrderLine);

// DELETE elimina riga ordine
router.delete('/order-lines/:id', orderLinesCtrl.deleteOrderLine);

module.exports = router; 