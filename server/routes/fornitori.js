//===============================================
//File: //routes//fornitori.js
//Script che definisce le rotte per le operazioni
//sui fornitori.
//@suthor: "villarin.andrea@libero.it"
//@version:"1.0.0 2025-07-08"
//===============================================

const express = require("express");
const router = express.Router();
console.log("🔵 routes/fornitori.js: File caricato, router creato.");

const fornitoriController = require("../controllers/fornitoricontrollers");

router.get("/", fornitoriController.getFornitori);
router.post("/", fornitoriController.insertFornitore);
router.put("/id", fornitoriController.updateFornitore);
router.delete("/id", fornitoriController.deleteFornitore);

module.exports = router;
