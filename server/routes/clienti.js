//===============================================
//File: //routes//clienti.js
//Script che definisce le rotte per le operazioni
//sui clienti.
//@suthor: "villarin.andrea@libero.it"
//@version:"1.0.0 2025-07-09"
//===============================================

const express = require("express");
const router = express.Router();
const logger = require('../utils/logger');
logger.info("routes/clienti.js: router creato");

const clientiController = require("../controllers/clienticontrollers");

router.get("/", clientiController.getClienti);
router.post("/", clientiController.insertCliente);
router.put("/id", clientiController.updateCliente);
router.delete("/id", clientiController.deleteCliente);

module.exports = router;
