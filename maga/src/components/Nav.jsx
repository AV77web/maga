import React, { useState } from "react";
import { NavLink as Link } from "react-router-dom";
import { RxTriangleRight, RxTriangleDown } from "react-icons/rx";
import "../css/Nav.css";

const Nav = ({ onLogout, currentUser }) => {
  const [isAnagraficheOpen, setIsAnagraficheOpen] = useState(false);

  const toggleAnagrafiche = () => {
    setIsAnagraficheOpen(!isAnagraficheOpen);
  };

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
      <Link to="/ordini" className="mylink">
        Ordini
      </Link>
      <Link to="/movimenti" className="mylink">
        Movimenti
      </Link>

      {/* Voce padre Anagrafiche */}
      <div className="mylink collapsible" onClick={toggleAnagrafiche}>
        <span>Anagrafiche</span>
        <span className="arrow">
          {isAnagraficheOpen ? <RxTriangleDown /> : <RxTriangleRight />}
        </span>
      </div>

      {/* Sotto-menu */}
      <div className={`submenu ${isAnagraficheOpen ? "open" : ""}`}>
        <Link to="/anagrafiche/clienti" className="mylink sublink">
          Clienti
        </Link>
        <Link to="/anagrafiche/fornitori" className="mylink sublink">
          Fornitori
        </Link>
      </div>

      {currentUser && currentUser.role === "admin" && (
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
