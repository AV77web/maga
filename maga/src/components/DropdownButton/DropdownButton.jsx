//==================================================
// File: DropdownButton.jsx 
// Componente per la visualizzazione del pulsante
// di un dropdown menu
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//==================================================

import React from "react";
import "./DropdownButton.css";

const DropdownButton = ({ 
  children, 
  onClick, 
  isOpen = false,
  disabled = false,
  className = "",
  icon = null,
  title = ""
}) => {
  return (
    <button 
      className={`dropdown-button ${isOpen ? 'open' : ''} ${disabled ? 'disabled' : ''} ${className}`}
      onClick={onClick}
      disabled={disabled}
      title={title}
    >
      {icon && <span className="dropdown-button-icon">{icon}</span>}
      {children && <span className="dropdown-button-text">{children}</span>}
      <span className="dropdown-button-arrow">
        {isOpen ? '▲' : '▼'}
      </span>
    </button>
  );
};

export default DropdownButton;