//==========================================
//File: // routes//ricambi.js
//Script che definisce le rotte per le operazioni API sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//==========================================
const express = require('express');
const router = express.Router();
// console.log("🔵 routes/ricambi.js: File caricato, router creato.");

const ricambiController = require('../controllers/ricambicontrollers');
// console.log("🔵 routes/ricambi.js: ricambiController caricato.", typeof ricambiController);
// if (ricambiController) {
//     console.log("🔵 routes/ricambi.js: typeof ricambiController.getRicambi:", typeof ricambiController.getRicambi);
// }

// GET /api/ricambi - Restituisce tutti i ricambi
router.get('/', (req, res, next) => {
    // console.log(`🔵 routes/ricambi.js: Raggiunto gestore GET / per URL: ${req.originalUrl}`);
    ricambiController.getRicambi(req, res, next);
});

// POST /api/ricambi - Inserisce un nuovo ricambio
router.post('/', ricambiController.insertRicambio);

// PUT /api/ricambi/:id - Modifica un ricambio esistente
router.put('/:id', ricambiController.updateRicambio);

// DELETE /api/ricambi/:id - Elimina un ricambio
router.delete('/:id', ricambiController.deleteRicambio);

module.exports = router;