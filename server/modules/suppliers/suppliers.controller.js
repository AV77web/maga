// server/modules/suppliers/suppliers.controller.js
//=================================================
// Suppliers Controller – wrapper sul vecchio fornitoriController
//=================================================
// ⚠️  Deprecato: ora si usa la tabella controparti.
//   Questo wrapper inoltra le richieste al controller controparti
//   forzando il campo tipo = 'FORNITORE'.

const counterpartiesCore = require('../../controllers/counterparticontrollers');

module.exports = {
  /**
   * GET /api/v1/suppliers
   */
  getSuppliers: (req, res, next) => {
    req.query = { ...req.query, tipo: 'FORNITORE' };
    return counterpartiesCore.getCounterparties(req, res, next);
  },

  /**
   * POST /api/v1/suppliers
   */
  insertSupplier: (req, res, next) => {
    req.body = { ...req.body, tipo: 'FORNITORE' };
    return counterpartiesCore.insertCounterparty(req, res, next);
  },

  /**
   * PUT /api/v1/suppliers/:id
   */
  updateSupplier: (req, res, next) => {
    req.body = { ...req.body, tipo: 'FORNITORE' };
    return counterpartiesCore.updateCounterparty(req, res, next);
  },

  /**
   * DELETE /api/v1/suppliers/:id
   */
  deleteSupplier: counterpartiesCore.deleteCounterparty,
}; 