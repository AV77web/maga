//=====================================
//File: //routes//dibaroutes.js
//Scrpt che definisce le rotte per le 
//operazioni API sulle diba
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-19"
//====================================
const express = require('express');
const router = express.Router();
console.log("🔵 routes/dibaroutes.js: File caricato, router creato.");

const dibaControllers = require('../controllers/dibacontrollers');
console.log("🔵 routes/dibaroutes.js: dibaControllers caricato.", typeof dibaControllers);
if (dibaControllers) {
 console.log("🔵 routes/dibaroutes.js typeof dibaControllers.getAllDiBa: ", typeof dibaControllers.getAllDiBa);
 console.log("🔵 routes/dibaroutes.js typeof dibaControllers.getBomByFatherId: ", typeof dibaControllers.getBomByFatherId); // Log per la nuova funzione
}

// GET /api/diba - Restituisce tutti gli elementi della distinta base (se necessario)
// router.get('/', (req, res, next) => {
//   dibaControllers.getAllDiBa(req, res, next);
// });

// GET /api/diba/father/:fatherId - Restituisce i componenti (figli) per un padre specifico
router.get('/father/:fatherId', (req, res, next) => {
 console.log(`🔵 route/dibaroutes.js: Raggiunto gestore GET /father/:fatherId per URL ${req.originalUrl}`);
 dibaControllers.getBomByFatherId(req, res, next);
});

// POST /api/diba - Inserisce un nuovo componente nella distinta base
router.post('/', dibaControllers.insertDiBa);

// PUT /api/diba/:id - Modifica un componente esistente nella distinta base
router.put('/:id', dibaControllers.updateDiBa);

// DELETE /api/diba/:id - Elimina un componente esistente dalla distinta base
router.delete('/:id', dibaControllers.deleteDiBa);

module.exports = router;