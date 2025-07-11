// server/modules/movements/movements.controller.js
//=================================================
// Movements Controller – wrapper sul vecchio movimenticontrollers
//=================================================
const movController = require('../../controllers/movimenticontrollers');

module.exports = {
  /**
   * GET /api/v1/movements
   */
  getMovements: movController.getMovimenti,
  /**
   * POST /api/v1/movements
   */
  insertMovement: movController.insertMovimento,
  /**
   * PUT /api/v1/movements/:id
   */
  updateMovement: movController.updateMovimento,
  /**
   * POST /api/v1/movements/custom-query (admin)
   */
  customQuery: movController.customQuery,
}; 