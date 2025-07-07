//================================================================
//File: ordini.js
//Script che definisce le rotte verso i metodi di ordinicontrollers.js
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-07"
// ==================================================================
// // server/routes/ordini.js (Esempio di file completo)


const express = require('express');
const router = express.Router();
const ordiniController = require('../controllers/ordinicontrollers');

// Rotte per la testata degli ordini
router.get('/', ordiniController.getOrdini);
router.post('/', ordiniController.insertOrdine);
router.put('/:id', ordiniController.updateOrdine);
router.delete('/:id', ordiniController.deleteOrdine);

// --- NUOVA ROTTA PER LE RIGHE ---
// Questa rotta recupera tutte le righe associate a un ordine specifico
router.get('/:ordineId/righe', ordiniController.getOrdineRighe);

module.exports = router;
