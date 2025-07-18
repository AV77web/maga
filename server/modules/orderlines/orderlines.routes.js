// server/modules/orderlines/orderlines.routes.js
//=================================================
// Rotte per le righe d'ordine (Order Lines) – v1
//=================================================
const express = require('express');
const router = express.Router();
const orderLinesController = require('./orderlines.controller');
const validateSchema = require('../../middleware/validateSchema');
const orderLineSchema = require('../../schemas/orderline.schema.json');

// POST /api/v1/orderlines - Crea una nuova riga d'ordine
router.post(
    '/', 
    validateSchema(orderLineSchema, { operation: 'create' }), 
    orderLinesController.createOrderLine
);

// PUT /api/v1/orderlines/:id - Aggiorna una riga d'ordine esistente
router.put(
    '/:id', 
    validateSchema(orderLineSchema, { operation: 'update' }), 
    orderLinesController.updateOrderLine
);

// DELETE /api/v1/orderlines/:id - Elimina una riga d'ordine
router.delete('/:id', orderLinesController.deleteOrderLine);

module.exports = router; 