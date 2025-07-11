//============================================
//File:authController.js
//Script che crea il controller per le operazoni
//sul login e del register
//@author: "villari.andrea@libero.it" 
//@version: "1.0.0 2025-06-17"
//============================================
const jwt = require('jsonwebtoken');
const pool = require('../db/db'); // Usa il pool di connessioni esportato da db.js
const bcrypt = require('bcryptjs'); // Importa bcryptjs

const JWT_SECRET = process.env.JWT_SECRET;
const SALT_ROUNDS = 10; // Numero di round per il salt di bcrypt. 10-12 è un buon compromesso.

// Funzione di LOGIN aggiornata con bcrypt
exports.login = async (req, res, next) => {
    
    const { username, password } = req.body;

    if (!username || !password) {
        // Questi controlli sono ora delegati alla validazione Ajv
        return res.status(400).json({ success: false, message: 'Validazione dati non riuscita.' });
    }
    try {
        // Seleziona l'ID, l'utente (username) e la password hashata (pwd)
        const [rows] = await pool.query('SELECT id, user, pwd, role  FROM login WHERE user = ? LIMIT 1', [username]);

        if (rows.length === 0) {
            return res.status(401).json({ success: false, message: 'Autenticazione fallita. Utente non trovato.' });
        }

        const userRecord = rows[0];

        // Confronta la password fornita con quella hashata nel database
        const isPasswordMatch = await bcrypt.compare(password, userRecord.pwd);

        if (isPasswordMatch) {
            const userPayload = {
                id: userRecord.id, // Assumendo che ci sia una colonna 'id' nella tabella 'login'
                username: userRecord.user, // Usa il valore dal DB
                role: userRecord.role,// include il ruolo nel payload del token 
                // Aggiungi altri dati utente non sensibili se necessario
            };
            const token = jwt.sign(userPayload, JWT_SECRET, { expiresIn: '1h' }); // Il token scade in 1 ora
            return res.json({ success: true, message: 'Login effettuato con successo!', token, user: userPayload });
        } else {
            return res.status(401).json({ success: false, message: 'Autenticazione fallita. Password errata.' });
        }
    } catch (error) {
        console.error('Errore durante il login:', error);
        next(error); // Passa l'errore al middleware centralizzato  
    }
};

// Nuova funzione di REGISTRAZIONE
exports.register = async (req, res, next) => {
    const { username, password } = req.body;

    if (!username || !password) {
        return res.status(400).json({ success: false, message: 'Validazione dati non riuscita.' });
    }
    // Controlli di lunghezza ora delegati allo schema

    try {
        // 1. Controlla se l'utente esiste già
        const [existingUsers] = await pool.query('SELECT id FROM login WHERE user = ? LIMIT 1', [username]);
        if (existingUsers.length > 0) {
            return res.status(409).json({ success: false, message: 'Username già esistente. Scegline un altro.' }); // 409 Conflict
        }

        // 2. Hasha la password
        const hashedPassword = await bcrypt.hash(password, SALT_ROUNDS);

        // 3. Salva il nuovo utente nel database
        // Assicurati che la colonna 'pwd' sia VARCHAR(60) o VARCHAR(255)
        const [result] = await pool.query('INSERT INTO login (user, pwd) VALUES (?, ?)', [username, hashedPassword]);

        // const newUserId = result.insertId; // Puoi usare l'ID se necessario

        return res.status(201).json({ success: true, message: 'Registrazione avvenuta con successo! Ora puoi effettuare il login.' });

    } catch (error) {
        console.error('Errore durante la registrazione:', error);
        next(error); // Passa l'errore al middleware centralizzato
    }
};

// Funzione di LOGOUT
exports.logout = (req, res) => {
    // Per JWT stateless, il logout lato server è principalmente per invalidare cookie di sessione HTTP-only se usati,
    // o per aggiungere il token a una blacklist se implementata.
    // In questo setup semplice con token in localStorage, il client si occupa di rimuovere il token.
    // Questa endpoint può rimanere semplice o essere estesa in futuro.
    res.json({ success: true, message: 'Logout effettuato con successo.' });
};