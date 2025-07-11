// server/modules/parts/parts.controller.js
//=================================================
// Parts Controller – wrapper che re-esporta la logica
// di ricambi usando la nuova convenzione di naming.
//=================================================
const ricambiController = require('../../controllers/ricambicontrollers');

module.exports = {
  /**
   * GET /api/v1/parts
   * Lista dei ricambi (parts) con filtri.
   */
  getParts: ricambiController.getRicambi,

  /**
   * POST /api/v1/parts
   * Inserisce un nuovo ricambio (part).
   */
  insertPart: ricambiController.insertRicambio,

  /**
   * PUT /api/v1/parts/:id
   * Aggiorna un ricambio esistente.
   */
  updatePart: ricambiController.updateRicambio,

  /**
   * DELETE /api/v1/parts/:id
   * Elimina un ricambio.
   */
  deletePart: ricambiController.deleteRicambio,
}; 