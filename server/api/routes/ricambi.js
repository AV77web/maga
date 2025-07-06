//============================
//File: routes/ricambi.js
//Script che crea le rotte per le operazioni sui ricambi
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//=============================
const express = require("express");
const router = express.Router();
const controller = require("./controllers/ricambiController");

router.get("/", controller.getRicambi);
router.post("/", controller.insertRicambio);
router.put("/:id", controller.updateRicambio);
router.delete("/:id", controller.deleteRicambio);

module.exports = router;
