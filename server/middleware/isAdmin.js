//=====================================
//File: isAdmin.js
//Middleware per verificare se l'utente 
//autenticato ha il ruolo 'admin'
//@author: "villari.andre@libero.it"
//@version: "1.0.0 2025-06-17"
//=======================================

function isAdmin(req, res, next) {
    // Questo middleware presume che authenticateToken sia stato eseguito prima
    // e che req.user sia popolato con il payload del token decodificato.
    if (req.user && req.user.role === 'admin') {
        next(); // L'utente è un admin, procedi
    } else {
        res.status(403).json({ success: false, message: 'Accesso negato. Privilegi di amministratore richiesti.' });
    }
}
module.exports = isAdmin;
