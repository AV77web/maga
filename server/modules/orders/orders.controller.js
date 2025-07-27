// server/modules/orders/orders.controller.js
//=================================================
// Orders Controller – wrapper sul vecchio ordinicontrollers
//=================================================
const ordiniController = require("../../controllers/ordinicontrollers");

module.exports = {
  /**
   * GET /api/v1/orders
   */
  getOrders: ordiniController.getOrdini,
  /**
   * GET /api/v1/orders/:id
   */
  getOrderById: ordiniController.getOrdineById,
  /**
   * GET /api/v1/orders/:orderId/items (righe ordine)
   */
  getOrderLines: ordiniController.getOrdineRighe,
  /**
   * POST /api/v1/orders
   */
  insertOrder: ordiniController.insertOrdine,
  /**
   * PUT /api/v1/orders/:id_ordine
   */
  updateOrder: ordiniController.updateOrdine,
  /**
   * DELETE /api/v1/orders/:id_ordine
   */
  deleteOrder: ordiniController.deleteOrdine,
};
