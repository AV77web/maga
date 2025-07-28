//=======================================
//File: Header.jsx
//Componente che gestisce i l'header della pagina
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2025-07-08"
//========================================
import React, { useState} from "react";
import { CgAdd, CgTrash } from "react-icons/cg"; // Assicurati che queste icone siano ancora necessarie
import { CiEdit, CiSearch, CiBoxList, CiCircleChevLeft, CiUser, CiSaveDown2, CiViewList } from "react-icons/ci"; // Importa le icone necessarie
import { FaChevronDown , FaChevronUp, FaColumns } from "react-icons/fa";
import Dropdown from "./Dropdown/Dropdown";
import DropdownContent from "./DropdownContent/DropdownContent";
import DropdownItem from "./DropdownItem/DropdownItem";
import "../css/Header.css";
//import { on } from "../../../server/db/db";

const Header = ({
  onAdd,
  onDelete,
  onEdit,
  editButtonIcon, // 'view' o 'edit'
  onSearch,
  onManageBOM,
  onSave, // Nuova prop per il salvataggio
  onBack,
  currentUser,
  currentLocation, // Accetta currentLocation come prop
  onLogout, // Aggiungi la prop onLogout
  onColumnVisibility, // Nuova prop per la gestione delle colonne
  columns = [], // Colonne disponibili
  visibleColumns = [] // Colonne visibili
}) => {
  // Determina se i pulsanti devono essere disabilitati in base alla posizione corrente
  const disableEditAndDelete = currentLocation === '/movimenti';
  const [ openDropdown, setOpenDropdown] = useState(false);
  const toggleDropdown = () => {
    console.log("Toggle dropdown, current state:", openDropdown);
    setOpenDropdown(!openDropdown);
  }

  // Debug per vedere le colonne
  console.log("Header - Colonne totali:", columns?.length);
  console.log("Header - Colonne visibili:", visibleColumns?.length);

  // Gestore per il cambio di visibilità delle colonne
  const handleColumnToggle = (columnKey, isVisible) => {
    if (onColumnVisibility) {
      onColumnVisibility(columnKey, isVisible);
    }
  };



  // Gestore per mostrare/nascondere tutte le colonne
  const handleSelectAll = () => {
    columns.forEach(col => {
      if (!visibleColumns.includes(col.key)) {
        handleColumnToggle(col.key, true);
      }
    });
  };

  const handleSelectNone = () => {
    visibleColumns.forEach(key => {
      handleColumnToggle(key, false);
    });
  };
  return (
    <div className="header-container">
      {onBack && ( // Mostra il pulsante solo se la prop onBack è definita
        <button className="icon-button back-button" onClick={onBack} title="Indietro">
          <CiCircleChevLeft />
        </button>
      )}
      
      {onManageBOM && (
        <button className="icon-button" onClick={onManageBOM} title="Distinta Base">
        <CiBoxList />
        </button>
      )}
      {onSearch && (
        <button className="icon-button" onClick={onSearch} title="Cerca">
        <CiSearch />
        </button>)}
      {onAdd &&  (
        <button className="icon-button" onClick={onAdd} title="Aggiungi">
        <CgAdd />
        </button>)}
      {onSave && ( // Mostra il pulsante Salva solo se la prop onSave è definita
        <button className="icon-button" onClick={onSave} title="Salva">
          <CiSaveDown2 />
        </button>
      )}
      { onEdit && (
        <button className="icon-button" onClick={onEdit} title="Modifica/Visualizza" disabled={disableEditAndDelete}>
        {editButtonIcon === 'view' ? <CiViewList /> : <CiEdit />}
        </button>
      )}      
      {onDelete && (
        <button className="icon-button" onClick={onDelete} title="Elimina" disabled={disableEditAndDelete}>
        <CgTrash />
      </button>)}
      {currentUser && currentUser.username && (
        <button className="icon-button user-button" title={`Logout User: ${currentUser.username}`} onClick={onLogout}>
          <CiUser />
          <span className="user-initials">
            {currentUser.username.substring(0, 2).toUpperCase()}
          </span>
        </button>
      )}
      {onColumnVisibility && columns.length > 0 && (
        <Dropdown
          trigger={
            <button className="icon-button" title="Visualizza/Nascondi colonne">
              <FaColumns />
            </button>
          }
          isOpen={openDropdown}
          onToggle={setOpenDropdown}
          position="bottom"
          style={{
            height: 'auto',
            maxHeight: 'none'
          }}
        >
          <DropdownContent 
            title="Colonne visibili"
            showHeader={true}
            style={{
              height: 'auto',
              maxHeight: 'none',
              overflow: 'visible'
            }}
          >
            <div className="column-visibility-actions">
              <DropdownItem 
                onClick={handleSelectAll}
                icon={<FaChevronDown />}
              >
                Mostra tutte
              </DropdownItem>
              <DropdownItem 
                onClick={handleSelectNone}
                icon={<FaChevronUp />}
              >
                Nascondi tutte
              </DropdownItem>
            </div>
            
            <DropdownItem type="separator" />
            
            <div 
              className="column-list"
              style={{
                display: 'flex',
                flexWrap: 'wrap',
                gap: '8px',
                padding: '8px',
                maxHeight: 'none',
                overflowY: 'visible',
                height: 'auto'
              }}
            >
              {console.log("Rendering column list, columns:", columns?.length)}
              {columns && columns.length > 0 ? (
                columns.map((column, index) => {
                  const isVisible = visibleColumns.includes(column.key);
                  console.log(`Rendering column ${index + 1}:`, column.key, column.label);
                  return (
                    <DropdownItem
                      key={column.key}
                      type="checkbox"
                      checked={isVisible}
                      onCheckChange={(checked) => handleColumnToggle(column.key, checked)}
                      icon={isVisible ? <FaChevronDown /> : <FaChevronUp />}
                      style={{
                        padding: '6px 8px',
                        fontSize: '12px',
                        minHeight: '32px',
                        display: 'flex',
                        alignItems: 'center',
                        borderRadius: '4px',
                        flex: '0 0 calc(50% - 4px)',
                        minWidth: '180px'
                      }}
                    >
                      {column.label || column.key}
                    </DropdownItem>
                  );
                })
              ) : (
                <DropdownItem disabled>
                  Nessuna colonna disponibile
                </DropdownItem>
              )}
            </div>
          </DropdownContent>
        </Dropdown>
      )}
    </div>
  );
};

export default Header;
