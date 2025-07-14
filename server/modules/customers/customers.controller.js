// server/modules/customers/customers.controller.js
//=================================================
// Customers Controller – wrapper del vecchio clienticontrollers
//=================================================
// ⚠️  Deprecato: ora si usa la tabella controparti.
//   Questo wrapper inoltra le richieste al controller controparti
//   forzando il campo tipo = 'CLIENTE'.

const counterpartiesCore = require('../../controllers/counterparticontrollers');

module.exports = {
  /**
   * GET /api/v1/customers
   */
  getCustomers: (req, res, next) => {
    req.query = { ...req.query, tipo: 'CLIENTE' };
    return counterpartiesCore.getCounterparties(req, res, next);
  },

  /**
   * POST /api/v1/customers
   */
  insertCustomer: (req, res, next) => {
    req.body = { ...req.body, tipo: 'CLIENTE' };
    return counterpartiesCore.insertCounterparty(req, res, next);
  },

  /**
   * PUT /api/v1/customers/:id
   */
  updateCustomer: (req, res, next) => {
    req.body = { ...req.body, tipo: 'CLIENTE' };
    return counterpartiesCore.updateCounterparty(req, res, next);
  },

  /**
   * DELETE /api/v1/customers/:id
   */
  deleteCustomer: counterpartiesCore.deleteCounterparty,
}; 