//==================================================
// File: ColumnVisibilityMenu.jsx
// Componente per il menu di visualizzazione/nascondimento delle colonne
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-28"
//==================================================

import React, { useState, useCallback } from "react";
import { FaEye, FaEyeSlash, FaColumns } from "react-icons/fa";
import Dropdown from "./Dropdown/Dropdown";
import DropdownContent from "./DropdownContent/DropdownContent";
import DropdownItem from "./DropdownItem/DropdownItem";
import "./css/ColumnVisibilityMenu.css";

const ColumnVisibilityMenu = ({ 
  columns = [], 
  visibleColumns = [], 
  onColumnVisibilityChange,
  className = ""
}) => {
  const [isOpen, setIsOpen] = useState(false);

  const handleToggle = useCallback((open) => {
    setIsOpen(open);
  }, []);

  const handleColumnToggle = useCallback((columnKey, checked) => {
    if (onColumnVisibilityChange) {
      onColumnVisibilityChange(columnKey, checked);
    }
  }, [onColumnVisibilityChange]);

  const handleSelectAll = useCallback(() => {
    const allColumnKeys = columns.map(col => col.key);
    allColumnKeys.forEach(key => {
      if (!visibleColumns.includes(key)) {
        handleColumnToggle(key, true);
      }
    });
  }, [columns, visibleColumns, handleColumnToggle]);

  const handleSelectNone = useCallback(() => {
    visibleColumns.forEach(key => {
      handleColumnToggle(key, false);
    });
  }, [visibleColumns, handleColumnToggle]);

  const visibleCount = visibleColumns.length;
  const totalCount = columns.length;

  return (
    <div className={`column-visibility-menu ${className}`}>
      <Dropdown
        trigger={
          <button 
            className="column-visibility-trigger"
            title="Visualizza/Nascondi colonne"
          >
            <FaColumns />
            <span className="column-count">
              {visibleCount}/{totalCount}
            </span>
          </button>
        }
        isOpen={isOpen}
        onToggle={handleToggle}
        position="bottom"
      >
        <DropdownContent 
          title="Colonne visibili"
          showHeader={true}
          maxHeight="400px"
        >
          <div className="column-visibility-actions">
            <DropdownItem 
              onClick={handleSelectAll}
              icon={<FaEye />}
            >
              Mostra tutte
            </DropdownItem>
            <DropdownItem 
              onClick={handleSelectNone}
              icon={<FaEyeSlash />}
            >
              Nascondi tutte
            </DropdownItem>
          </div>
          
          <DropdownItem type="separator" />
          
          <div className="column-list">
            {columns.map((column) => {
              const isVisible = visibleColumns.includes(column.key);
              return (
                <DropdownItem
                  key={column.key}
                  type="checkbox"
                  checked={isVisible}
                  onCheckChange={(checked) => handleColumnToggle(column.key, checked)}
                  icon={isVisible ? <FaEye /> : <FaEyeSlash />}
                >
                  {column.label || column.key}
                </DropdownItem>
              );
            })}
          </div>
        </DropdownContent>
      </Dropdown>
    </div>
  );
};

export default ColumnVisibilityMenu; 