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
    setOpenDropdown(!openDropdown);
  }

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
            className={columns.length > 15 ? 'many-columns' : ''}
            style={{
              height: 'auto',
              maxHeight: 'none',
              overflow: 'visible',
              minHeight: columns.length > 15 ? '500px' : '300px',
              minWidth: columns.length > 15 ? '1000px' : '600px',
              maxWidth: columns.length > 15 ? '1600px' : '800px'
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
              className={`column-list ${columns.length > 12 ? 'many-columns' : ''}`}
              style={{
                display: 'grid',
                gridTemplateColumns: columns.length > 12 ? 'repeat(6, 1fr)' : 'repeat(3, 1fr)',
                gap: '8px',
                padding: '8px',
                maxHeight: 'none',
                overflowY: 'visible',
                height: 'auto',
                width: '100%',
                minHeight: columns.length > 15 ? '450px' : '250px'
              }}
            >
              {columns && columns.length > 0 ? (
                columns.map((column, index) => {
                  const isVisible = visibleColumns.includes(column.key);
                  return (
                    <DropdownItem
                      key={`${column.key}-${isVisible}`}
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
                        width: '100%',
                        minWidth: '120px'
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
