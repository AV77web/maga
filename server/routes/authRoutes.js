//========================================
// File: authRoutes.js
// Script per la gestione delle rotte verso
// il Login e Register
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-06-17"
//=========================================
const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const userController = require('../controllers/userController');
// Assicurati che il percorso a authenticateToken e isAdmin sia corretto
const authenticateToken = require('../middleware/authenticateToken'); 
const isAdmin = require('../middleware/isAdmin'); 
const validateSchema = require('../middleware/validateSchema');
const loginSchema = require('../schemas/login.schema.json');
const registerSchema = require('../schemas/register.schema.json');

// GET /api/auth/users - Nuova rotta pubblica per ottenere la lista degli utenti per il login
router.get('/users', userController.getUsers);

// POST /api/auth/login
router.post('/login', validateSchema(loginSchema), authController.login);

// POST /api/auth/register
router.post('/register', authenticateToken, isAdmin, validateSchema(registerSchema), authController.register); 

// POST /api/auth/logout - Richiede token perché solo un utente loggato può fare logout
router.post('/logout', authenticateToken, authController.logout);

module.exports = router;