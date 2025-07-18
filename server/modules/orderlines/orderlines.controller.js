//========================================
// File: orderlines.controller.js
// Proxy verso il controller centralizzato
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-16"
//========================================

const centralizedController = require('../../controllers/ordinilinecontrollers');

module.exports = {
  /**
   * GET /api/v1/orders/:orderId/items
   */
  getOrderLines: centralizedController.getOrderLines,
  /**
   * POST /api/v1/orderlines
   */
  createOrderLine: centralizedController.insertOrderLine,
  /**
   * PUT /api/v1/orderlines/:id
   */
  updateOrderLine: centralizedController.updateOrderLine,
  /**
   * DELETE /api/v1/orderlines/:id
   */
  deleteOrderLine: centralizedController.deleteOrderLine,
}; 