//==================================================
//File: // routes//movimentiRoutes.js
//Script che definisce le rotte per le operazioni API sui movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================================
const express = require('express');
const router = express.Router();
console.log("LOG SERVER: Caricamento di movimentiRoutes.js..."); // <-- NUOVO LOG
const movimentiController = require('../controllers/movimenticontrollers');


// restituisce i movimenti della query personalizzata
router.post('/customquery', movimentiController.customQuery);

console.log("LOG SERVER: Definizione rotta GET /api/movimenti"); // <-- NUOVO LOG
// GET /api/movimenti - Restituisce tutti i movimenti
router.get('/', movimentiController.getMovimenti);

// POST /api/movimenti - Inserisce un nuovo movimento
router.post('/', movimentiController.insertMovimento);

// PUT /api/movimenti/:id - Modifica un movimento esistente
router.put('/:id', movimentiController.updateMovimento);

// DELETE /api/movimenti/:id - Elimina un movimento
//router.delete('/:id', movimentiController.deleteMovimento);

module.exports = router;