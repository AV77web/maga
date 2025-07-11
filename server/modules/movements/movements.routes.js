// server/modules/movements/movements.routes.js
//=================================================
// Rotte Movements – v1
//=================================================
const express = require('express');
const router = express.Router();
const movementsController = require('./movements.controller');
const isAdmin = require('../../middleware/isAdmin');
const validateSchema = require('../../middleware/validateSchema');
const movementSchema = require('../../schemas/movement.schema.json');

router.post('/custom-query', isAdmin, movementsController.customQuery);
router.get('/', movementsController.getMovements);
router.post('/', validateSchema(movementSchema), movementsController.insertMovement);
router.put('/:id', validateSchema(movementSchema), movementsController.updateMovement);
// DELETE non implementato lato DB, mantenere per futuri update
// router.delete('/:id', movementsController.deleteMovement);

module.exports = router; 