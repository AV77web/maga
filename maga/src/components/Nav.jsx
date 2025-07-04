//=====================================
//File: Nav.jsx
//Programma per la gestione del menu di
//navigazione.
//@author = "villari.andrea@libero.it"
//@version = "1.0.0 2025-05-23"
//=====================================
import React from "react";
import { NavLink as  Link } from "react-router-dom";
import "../css/Nav.css";

const Nav = ({ onLogout, currentUser }) => { // Accetta onLogout e currentUser come prop
  return (
    <nav>
      <Link to="/" className="mylink">
        Home
      </Link>
      <Link to="/articoli" className="mylink">
        Articoli
      </Link>
      <Link to="/causali" className="mylink">
        Causali
      </Link>
      <Link to="/movimenti" className="mylink"> {/* Aggiunto per coerenza con App.jsx */}
        Movimenti
      </Link>
      {currentUser && currentUser.role === 'admin' && (
        <Link to="/register" className="mylink">
          Registra Utente
        </Link>
      )}
      {onLogout && (
        <button onClick={onLogout} className="mylink logout-button">
          Logout
        </button>
      )}
    </nav>
  );
};

export default Nav;
