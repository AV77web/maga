//==============================
//File: Login.jsx
//Programma di gestione del Login di accesso.
//@author = "villari.andrea@libero.it"
//@version = "1.0.0 2025-05-21"
//==============================

import React, { useState, useEffect } from "react";
import axios from "axios";
import "../css/Login.css"; // se usi un file separato

function Login({ onSuccess }) {
  const [username, setUsername] = useState(""); 
  const [password, setPassword] = useState(""); // Modificato da 'pwd' a 'password'
  const [error, setError] = useState(""); // Definisci lo stato per l'errore
  const [users, setUsers] = useState([]);
  const [loadingUsers, setLoadingUsers] = useState(true);

  useEffect(() => {
    const fetchUsers = async () => {
      setLoadingUsers(true);
      setError("");
      try {
        // Utilizzo axios direttamente per evitare di inviare un token non ancora disponibile,
        // La rotta è stata spostata su /api/auth/users per renderla pubblica.
        const response = await axios.get("http://localhost:3001/api/auth/users");
        const userList = response.data.data; // Estraggo l'array dall'oggetto di risposta
        if (Array.isArray(userList)) {
          setUsers(userList);
        } else {
          setError("Impossibile caricare la lista degli utenti.");
        }
      } catch (err) {
        setError(err.response?.data?.message || "Errore nel caricamento degli utenti. Riprova più tardi.");
      } finally {
        setLoadingUsers(false);
      }
    };

    fetchUsers();
  }, []); // L'array vuoto assicura che venga eseguito solo una volta al mount

  const handleLogin = async (e) => {
    e.preventDefault();
    setError(""); // Resetta l'errore ad ogni tentativo
    try {
      const res = await axios.post("http://localhost:3001/api/auth/login", {
        username,
        password,
      });
      if (res.data.success) {
        console.log("Login riuscito:", res.data.user);
        // Salva il token ricevuto per le richieste successive
        localStorage.setItem('authToken', res.data.token);
                // Salva i dati dell'utente, inclusa la role, se disponibili
        if (res.data.user) {
          localStorage.setItem('user', JSON.stringify(res.data.user));
        }
        onSuccess();
      } else {
        setError(res.data.message || "Credenziali errate");
      }
    } catch (err) {
      setError(err.response?.data?.message || "Errore di connessione o credenziali non valide.");
    }
  };

  return (
    <div className="login-container">
      <div className="login-card">
        <h2>Login</h2>
        <form onSubmit={handleLogin} className="login-form">
          <select
            value={username}
            onChange={(e) => setUsername(e.target.value)}
            required
            disabled={loadingUsers}
          >
            <option value="">-- Seleziona Utente --</option>
            {loadingUsers ? (
              <option disabled>Caricamento utenti...</option>
            ) : (
              users.map((user) => (
                <option key={user.id || user.username} value={user.username}>
                  {user.username}
                </option>
              ))
            )}
          </select>
          <input
            type="password"
            placeholder="Password"
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            required
          />
          {error && <p className="login-error">{error}</p>}
          <button type="submit">Accedi</button>
        </form>
      </div>
    </div>
  );
}

export default Login;
