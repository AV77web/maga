//=======================================
//File: Header.jsx
//Componente che gestisce i l'header della pagina
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//========================================
import React from "react";
import { CgAdd, CgTrash } from "react-icons/cg"; // Assicurati che queste icone siano ancora necessarie
import { CiEdit, CiSearch, CiBoxList, CiCircleChevLeft, CiUser } from "react-icons/ci"; // Importa l'icona Indietro
import "../css/Header.css";
//import { on } from "../../../server/db/db";

const Header = ({
  onAdd,
  onDelete,
  onEdit,
  onSearch,
  onManageBOM,
  onBack,
  currentUser,
  currentLocation, // Accetta currentLocation come prop
  onLogout // Aggiungi la prop onLogout
}) => {
  // Determina se i pulsanti devono essere disabilitati in base alla posizione corrente
  const disableEditAndDelete = currentLocation === '/movimenti';

  return (
    <div className="header-container">
      {onBack && ( // Mostra il pulsante solo se la prop onBack è definita
        <button className="icon-button back-button" onClick={onBack} title="Indietro">
          <CiCircleChevLeft />
        </button>
      )}
      <button className="icon-button" onClick={onManageBOM} title="Distinta Base">
        <CiBoxList />
      </button>
      <button className="icon-button" onClick={onSearch} title="Cerca">
        <CiSearch />
      </button>
      <button className="icon-button" onClick={onAdd} title="Aggiungi">
        <CgAdd />
      </button>
      <button className="icon-button" onClick={onEdit} title="Aggiorna" disabled={disableEditAndDelete}>
        <CiEdit />
      </button>
      <button className="icon-button" onClick={onDelete} title="Elimina" disabled={disableEditAndDelete}>
        <CgTrash />
      </button>
      {currentUser && currentUser.username && (
        <button className="icon-button user-button" title={`Logout User: ${currentUser.username}`} onClick={onLogout}>
          <CiUser />
          <span className="user-initials">
            {currentUser.username.substring(0, 2).toUpperCase()}
          </span>
        </button>
      )}
    </div>
  );
};

export default Header;
