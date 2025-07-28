//==================================================
// File: DropdownContent.jsx
// Componente per contenere gli elementi del dropdown menu
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//==================================================

import React from "react";
import "./DropdownContent.css";

const DropdownContent = ({ 
  children, 
  className = "",
  title = "",
  showHeader = false,
  maxHeight = "300px"
}) => {
  return (
    <div className={`dropdown-content-wrapper ${className}`} style={{ maxHeight }}>
      {showHeader && title && (
        <div className="dropdown-header">
          <h3 className="dropdown-title">{title}</h3>
        </div>
      )}
      <div className="dropdown-items-container">
        {children}
      </div>
    </div>
  );
};

export default DropdownContent;