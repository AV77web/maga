//============================================
//File:authController.js
//Script che crea il controller per la gestione
//del login e del register
//@author: "villari.andrea@libero.it" 
//@version: "1.0.0 2025-06-17"
//============================================

const jwt = require('jsonwebtoken');
const db = require('../db/db'); // Assumendo che il tuo file di connessione al DB sia qui
// const bcrypt = require('bcryptjs'); // Raccomandato per hashare le password

const JWT_SECRET = process.env.JWT_SECRET;

exports.login = async (req, res) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ success: false, message: 'Username e password sono richiesti.' });
    }

    try {
        // Esempio: Verifica utente nel database (ADATTA QUESTO ALLA TUA STRUTTURA DB)
        // In un'applicazione reale, dovresti:
        // 1. Cercare l'utente per username.
        // 2. Comparare la password fornita con quella hashata nel DB usando bcrypt.
        // const [users] = await db.query('SELECT * FROM users WHERE username = ?', [username]);
        // if (users.length === 0) {
        //     return res.status(401).json({ success: false, message: 'Autenticazione fallita. Utente non trovato.' });
        // }
        // const user = users[0];
        // const isPasswordMatch = await bcrypt.compare(password, user.password_hash);
        // if (!isPasswordMatch) {
        //     return res.status(401).json({ success: false, message: 'Autenticazione fallita. Password errata.' });
        // }

        // *** Inizio Blocco Semplificato per Dimostrazione (DA SOSTITUIRE) ***
        if (username === 'testuser' && password === 'password123') { // SOSTITUISCI con la logica DB reale
            const userPayload = {
                id: 1, // Esempio: user.id
                username: username,
                // Aggiungi altri dati utente non sensibili se necessario
            };
            const token = jwt.sign(userPayload, JWT_SECRET, { expiresIn: '1h' }); // Il token scade in 1 ora

            return res.json({ success: true, message: 'Login effettuato con successo!', token, user: userPayload });
        } else {
            return res.status(401).json({ success: false, message: 'Credenziali non valide.' });
        }
        // *** Fine Blocco Semplificato ***

    } catch (error) {
        console.error('Errore durante il login:', error);
        res.status(500).json({ success: false, message: 'Errore del server durante il login.' });
    }
};
