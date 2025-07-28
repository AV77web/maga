//===========================================
// File: Dropdown.jsx
// Componente per visualizzare un dropdown menu
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//============================================

import React, { useState, useRef, useEffect } from "react";
import "./Dropdown.css";

const Dropdown = ({ 
  trigger, 
  children, 
  isOpen, 
  onToggle, 
  className = "",
  position = "bottom" // 'top', 'bottom', 'left', 'right'
}) => {
  const dropdownRef = useRef(null);

  // Gestisce il click fuori dal dropdown per chiuderlo
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        onToggle(false);
      }
    };

    if (isOpen) {
      document.addEventListener('mousedown', handleClickOutside);
    }

    return () => {
      document.removeEventListener('mousedown', handleClickOutside);
    };
  }, [isOpen, onToggle]);

  return (
    <div className={`dropdown-container ${className}`} ref={dropdownRef}>
      <div className="dropdown-trigger" onClick={() => onToggle(!isOpen)}>
        {trigger}
      </div>
      {isOpen && (
        <div className={`dropdown-content dropdown-${position}`}>
          {children}
        </div>
      )}
    </div>
  );
};

export default Dropdown;