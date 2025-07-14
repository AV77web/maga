import React, { useState } from "react";
import { NavLink as Link } from "react-router-dom";
import { RxTriangleRight, RxTriangleDown } from "react-icons/rx";
import "../css/Nav.css";

const Nav = ({ onLogout, currentUser }) => {
  const [openMenu, setOpenMenu] = useState(null); // null | "movimenti" | "anagrafiche"

  const toggleMenu = (menuName) => {
    setOpenMenu((prev) => (prev === menuName ? null : menuName));
  };

  return (
    <nav>
      {/* Voci principali */}
      <Link to="/" className="mylink">
        Home
      </Link>
      <Link to="/articoli" className="mylink">
        Articoli
      </Link>
      <Link to="/ordini" className="mylink">
        Ordini
      </Link>

      {/* Voce padre Movimenti */}
      <div
        className="mylink collapsible"
        onClick={() => toggleMenu("movimenti")}
      >
        <span>Movimenti</span>
        <span className="arrow">
          {openMenu === "movimenti" ? <RxTriangleDown /> : <RxTriangleRight />}
        </span>
      </div>
      {/* Sotto-menu Movimenti */}
      <div className={`submenu ${openMenu === "movimenti" ? "open" : ""}`}>
        <Link to="/causali" className="mylink sublink">
          Causali
        </Link>
      </div>

      {/* Voce padre Anagrafiche */}
      <div
        className="mylink collapsible"
        onClick={() => toggleMenu("anagrafiche")}
      >
        <span>Anagrafiche</span>
        <span className="arrow">
          {openMenu === "anagrafiche" ? (
            <RxTriangleDown />
          ) : (
            <RxTriangleRight />
          )}
        </span>
      </div>
      {/* Sotto-menu Anagrafiche */}
      <div className={`submenu ${openMenu === "anagrafiche" ? "open" : ""}`}>
        <Link to="/anagrafiche/controparti" className="mylink sublink">
          Controparti
        </Link>
      </div>

      {/* Admin only */}
      {currentUser?.role === "admin" && (
        <Link to="/register" className="mylink">
          Registra Utente
        </Link>
      )}

      {/* Logout */}
      {onLogout && (
        <button onClick={onLogout} className="mylink logout-button">
          Logout
        </button>
      )}
    </nav>
  );
};

export default Nav;
