//====================================
//File: // routes//causaliroutes.js
//Script che definisce le rotte per le 
//operazioni API sulle causali
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//=====================================

const express = require('express');
const router = express.Router();
const logger = require('../utils/logger');
logger.info("routes/causaliroutes.js: router creato");

const causaliController = require('../controllers/causalicontrollers');
logger.debug({ type: typeof causaliController }, "causaliController caricato");
if (causaliController) {
  logger.debug({ fnType: typeof causaliController.getCausali }, "Tipo getCausali");
}

//GET /api/causali - Restituisce tutti le causali
router.get('/', (req, res, next) => {
  //console.log(`🔵 route/causaliroutes.js: Raggiunto gestore GET / per URL ${req.originalUrl}`);)
  causaliController.getCausali(req, res, next);
});

// POST /api/causali - Inserisce una nuova causale
router.post('/', causaliController.insertCausale);

// PUT /api/causali/:id - Modifica una causale esistente
//router.put('/:id', causaliController.updateCausale);

// DELETE /api/causali/:id - Elimina una causale esistente
//router.delete('/:id', causaliController.deleteCausale);

module.exports = router;