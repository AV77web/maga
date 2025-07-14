// server/modules/counterparties/counterparties.controller.js
//=================================================
// Counterparties Controller – wrapper che re-esporta la logica
// dell'unica tabella "controparti".
//=================================================
const counterpartiesCore = require('../../controllers/counterparticontrollers');

module.exports = {
  /**
   * GET /api/v1/counterparties
   */
  getCounterparties: counterpartiesCore.getCounterparties,
  /**
   * POST /api/v1/counterparties
   */
  insertCounterparty: counterpartiesCore.insertCounterparty,
  /**
   * PUT /api/v1/counterparties/:id
   */
  updateCounterparty: counterpartiesCore.updateCounterparty,
  /**
   * DELETE /api/v1/counterparties/:id
   */
  deleteCounterparty: counterpartiesCore.deleteCounterparty,
}; 