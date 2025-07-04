//===============================================================
// File: userController.js
// Script per la gestione delle operazioni relative agli utenti.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-03"
//===============================================================

const pool = require('../db/db');

/**
 * Gestisce la richiesta per ottenere tutti gli utenti tramite la stored procedure 'FetchUser'.
 * @param {object} req - L'oggetto richiesta di Express.
 * @param {object} res - L'oggetto risposta di Express.
 * @param {function} next - La funzione middleware successiva.
 */
const getUsers = async (req, res, next) => {
  try {
    // Chiama la stored procedure passando NULL per ottenere tutti gli utenti
    const [rows] = await pool.query('CALL FetchUsers(NULL, NULL)');
    res.json({ success: true, data: rows[0] });
  } catch (error) {
    console.error("Errore durante l'esecuzione della stored procedure FetchUser:", error);
    next(error); // Passa l'errore al gestore di errori centralizzato
  }
};

module.exports = {
  getUsers,
};