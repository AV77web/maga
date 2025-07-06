// c:\maga\server\middleware\authenticateToken.js
const jwt = require('jsonwebtoken');
const JWT_SECRET = process.env.JWT_SECRET;

function authenticateToken(req, res, next) {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1]; // Formato atteso: Bearer TOKEN

    if (token == null) {
        return res.status(401).json({ success: false, message: 'Accesso negato. Token non fornito.' });
    }

    jwt.verify(token, JWT_SECRET, (err, user) => {
        if (err) {
            if (err.name === 'TokenExpiredError') {
                return res.status(403).json({ success: false, message: 'Accesso negato. Token scaduto.' });
            }
            console.error('Errore verifica JWT:', err.message);
            return res.status(403).json({ success: false, message: 'Accesso negato. Token non valido.' });
        }
        req.user = user; // Aggiunge il payload dell'utente decodificato all'oggetto request
        next(); // Passa al prossimo middleware o al gestore della rotta
    });
}

module.exports = authenticateToken;
