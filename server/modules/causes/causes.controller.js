// server/modules/causes/causes.controller.js
//=================================================
// Causes Controller – wrapper sul vecchio causalicontrollers
//=================================================
const causesControllerOld = require('../../controllers/causalicontrollers');

module.exports = {
  /**
   * GET /api/v1/causes
   */
  getCauses: causesControllerOld.getCausali,
  /**
   * POST /api/v1/causes
   */
  insertCause: causesControllerOld.insertCausale,
  // Aggiornamento/eliminazione non implementati nel controller originale
}; 