//==================================================
// File: DropdownItem.jsx
// Componente per gli elementi singoli del dropdown menu
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//==================================================

import React from "react";
import "./DropdownItem.css";

const DropdownItem = ({ 
  children, 
  onClick, 
  className = "",
  disabled = false,
  icon = null,
  type = "default", // 'default', 'checkbox', 'radio', 'separator'
  checked = false,
  onCheckChange = null
}) => {
  const handleClick = (e) => {
    if (disabled) return;
    
    if (type === "checkbox" && onCheckChange) {
      e.preventDefault();
      onCheckChange(!checked);
    } else if (onClick) {
      onClick(e);
    }
  };

  if (type === "separator") {
    return <div className="dropdown-separator" />;
  }

  return (
    <div 
      className={`dropdown-item dropdown-item-${type} ${disabled ? 'disabled' : ''} ${className}`}
      onClick={handleClick}
      role={type === "checkbox" ? "checkbox" : "menuitem"}
      aria-checked={type === "checkbox" ? checked : undefined}
    >
      {type === "checkbox" && (
        <input 
          type="checkbox" 
          checked={checked} 
          onChange={(e) => {
            e.stopPropagation();
            if (onCheckChange) {
              onCheckChange(e.target.checked);
            }
          }}
          className="dropdown-checkbox"
        />
      )}
      {icon && <span className="dropdown-item-icon">{icon}</span>}
      <span className="dropdown-item-text">{children}</span>
    </div>
  );
};

export default DropdownItem;
