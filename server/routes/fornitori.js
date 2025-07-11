//===============================================
//File: //routes//fornitori.js
//Script che definisce le rotte per le operazioni
//sui fornitori.
//@suthor: "villarin.andrea@libero.it"
//@version:"1.0.0 2025-07-08"
//===============================================

const express = require("express");
const router = express.Router();
const logger = require('../utils/logger');
logger.info("routes/fornitori.js: router creato");

const fornitoriController = require("../controllers/fornitoricontrollers");

router.get("/", fornitoriController.getFornitori);
router.post("/", fornitoriController.insertFornitore);
router.put("/id", fornitoriController.updateFornitore);
router.delete("/id", fornitoriController.deleteFornitore);

module.exports = router;
