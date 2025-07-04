//====================================================
//File: Register.jsx
//Componente per la gestione della Registrazione di un 
//nuovo utente.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-17"
//====================================================

import React, { useState } from "react";
import axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import "../css/Login.css"; // Puoi riutilizzare lo stesso CSS o crearne uno nuovo

function Register() {
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");
  const [confirmPassword, setConfirmPassword] = useState("");
  const [role, setRole] = useState("user"); // Stato per il ruolo, default 'user'
  const [error, setError] = useState("");
  const [successMessage, setSuccessMessage] = useState("");
  const navigate = useNavigate();

  const handleRegister = async (e) => {
    e.preventDefault();
    setError("");
    setSuccessMessage("");

    if (password !== confirmPassword) {
      setError("Le password non coincidono.");
      return;
    }
    if (password.length < 6) {
        setError("La password deve essere di almeno 6 caratteri.");
        return;
    }
    // Potresti aggiungere altre validazioni qui (es. formato email per username)

    try {
      const token = localStorage.getItem('authToken');
      if (!token) {
        setError("Token di autenticazione non trovato. Effettua nuovamente il login.");
        return;
      }

      const res = await axios.post("http://localhost:3001/api/auth/register", {
        username,
        password,
        role, // Includi il ruolo nella richiesta
      }, {
        headers: { 'Authorization': `Bearer ${token}` } // Invia il token nell'header
      });

      if (res.data.success) {
        setSuccessMessage(res.data.message + " Sarai reindirizzato al login tra poco...");
        setTimeout(() => {
          navigate("/login"); // Reindirizza alla pagina di login
        }, 3000); // Attendi 3 secondi prima di reindirizzare
      } else {
        // Questo blocco potrebbe non essere raggiunto se il server usa codici di stato HTTP per errori (es. 409, 400)
        setError(res.data.message || "Errore durante la registrazione.");
      }
    } catch (err) {
      if (err.response && err.response.status === 401) {
        setError("Non autorizzato. Assicurati di essere loggato come admin e che la sessione sia valida.");
      } else {
        setError(err.response?.data?.message || "Errore del server o di rete durante la registrazione.");
      }
    }
  };

  return (
    <div className="login-container"> {/* Riutilizza la classe per lo stile */}
      <div className="login-card">
        <h2>Registrazione</h2>
        <form onSubmit={handleRegister} className="login-form">
          <input
            type="email" // o text, a seconda se l'username è un'email
            placeholder="Username (es. email)"
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Password (min. 6 caratteri)"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          <input
            type="password"
            placeholder="Conferma Password"
            value={confirmPassword}
            onChange={(e) => setConfirmPassword(e.target.value)}
            required
          />
          <div className="form-group"> {/* Aggiunto un div per raggruppare label e select */}
            <label htmlFor="role-select" style={{ marginRight: '10px', display: 'block', marginBottom: '5px' }}>Ruolo:</label>
            <select id="role-select" value={role} onChange={(e) => setRole(e.target.value)} required className="role-select">
              <option value="user">User</option>
              <option value="admin">Admin</option>
              {/* Aggiungi altri ruoli se necessario */}
            </select>
          </div>
          {error && <p className="login-error">{error}</p>}
          {successMessage && <p style={{ color: 'green', textAlign: 'center' }}>{successMessage}</p>}
          <button type="submit">Registrati</button>
        </form>
      <p style={{ marginTop: '1rem', textAlign: 'center' }}>
        Hai già un account? <Link to="/login">Accedi qui</Link>
      </p>
      </div>
    </div>
  );
}

export default Register;
