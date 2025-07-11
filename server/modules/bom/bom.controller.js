// server/modules/bom/bom.controller.js
//=================================================
// BOM Controller – wrapper sul vecchio dibacontrollers
//=================================================
const dibaController = require('../../controllers/dibacontrollers');

module.exports = {
  /**
   * GET /api/v1/bom
   */
  getAllBom: dibaController.getAllDiBa,
  /**
   * GET /api/v1/bom/father/:fatherId
   */
  getBomByFather: dibaController.getBomByFatherId,
  /**
   * POST /api/v1/bom
   */
  insertBom: dibaController.insertDiBa,
  /**
   * PUT /api/v1/bom/:id
   */
  updateBom: dibaController.updateDiBa,
  /**
   * DELETE /api/v1/bom/:id
   */
  deleteBom: dibaController.deleteDiBa,
}; 