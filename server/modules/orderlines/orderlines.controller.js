//========================================
// File: orderlines.controller.js
// Proxy verso il controller centralizzato
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-16"
//========================================
const ctrl = require('../../controllers/ordinilinecontrollers');

module.exports = { 
    getOrderLines: ctrl.getOrderLines,
    insertOrderLine: ctrl.insertOrderLine,
    updateOrderLine: ctrl.updateOrderLine,
    deleteOrderLine: ctrl.deleteOrderLine,
}; 