// server/modules/customers/customers.controller.js
//=================================================
// Customers Controller – wrapper del vecchio clienticontrollers
//=================================================
const clientiController = require('../../controllers/clienticontrollers');

module.exports = {
  /**
   * GET /api/v1/customers
   */
  getCustomers: clientiController.getClienti,
  /**
   * POST /api/v1/customers
   */
  insertCustomer: clientiController.insertCliente,
  /**
   * PUT /api/v1/customers/:id
   */
  updateCustomer: clientiController.updateCliente,
  /**
   * DELETE /api/v1/customers/:id
   */
  deleteCustomer: clientiController.deleteCliente,
}; 