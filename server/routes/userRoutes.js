// File: c:\maga\server\routes\userRoutes.js
const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');

// GET /api/users - Recupera tutti gli utenti (solo username e ruolo per sicurezza)
router.get('/', userController.getUsers);

module.exports = router;
