// server/modules/movements/movements.routes.js
//=================================================
// Rotte Movements – v1
//=================================================
const express = require('express');
const router = express.Router();
const movementsController = require('./movements.controller');
const isAdmin = require('../../middleware/isAdmin');

router.post('/custom-query', isAdmin, movementsController.customQuery);
router.get('/', movementsController.getMovements);
router.post('/', movementsController.insertMovement);
router.put('/:id', movementsController.updateMovement);
// DELETE non implementato lato DB, mantenere per futuri update
// router.delete('/:id', movementsController.deleteMovement);

module.exports = router; 