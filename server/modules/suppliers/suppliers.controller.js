// server/modules/suppliers/suppliers.controller.js
//=================================================
// Suppliers Controller – wrapper sul vecchio fornitoriController
//=================================================
const fornitoriController = require('../../controllers/fornitoricontrollers');

module.exports = {
  /**
   * GET /api/v1/suppliers
   */
  getSuppliers: fornitoriController.getFornitori,
  /**
   * POST /api/v1/suppliers
   */
  insertSupplier: fornitoriController.insertFornitore,
  /**
   * PUT /api/v1/suppliers/:id
   */
  updateSupplier: fornitoriController.updateFornitore,
  /**
   * DELETE /api/v1/suppliers/:id
   */
  deleteSupplier: fornitoriController.deleteFornitore,
}; 