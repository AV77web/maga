//====================================
//File: // routes//causaliroutes.js
//Script che definisce le rotte per le 
//operazioni API sulle causali
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//=====================================

const express = require('express');
const router = express.Router();
 console.log("🔵 routes/causaliroutes.js: File caricato, router creato.");

const causaliController = require('../controllers/causalicontrollers');
 console.log("🔵 routes/causaliroutes.js: causaliController caricato.", typeof causaliController);
 if (causaliController) {
  console.log("🔵 routes/causaliroutes.js typeof causaliController.getCausali: " , typeof causaliController.getCausali)
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