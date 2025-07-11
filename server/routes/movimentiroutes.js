//==================================================
//File: // routes//movimentiRoutes.js
//Script che definisce le rotte per le operazioni API sui movimenti
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================================
const express = require('express');
const router = express.Router();
const logger = require('../utils/logger');
logger.info("Caricamento movimentiRoutes.js");
const movimentiController = require('../controllers/movimenticontrollers');
const isAdmin = require('../middleware/isAdmin');


// 🔒  Limita l'endpoint customquery agli utenti con ruolo 'admin'
router.post('/customquery', isAdmin, movimentiController.customQuery);

logger.debug("Definizione rotta GET /api/movimenti");
// GET /api/movimenti - Restituisce tutti i movimenti
router.get('/', movimentiController.getMovimenti);

// POST /api/movimenti - Inserisce un nuovo movimento
router.post('/', movimentiController.insertMovimento);

// PUT /api/movimenti/:id - Modifica un movimento esistente
router.put('/:id', movimentiController.updateMovimento);

// DELETE /api/movimenti/:id - Elimina un movimento
//router.delete('/:id', movimentiController.deleteMovimento);

module.exports = router;