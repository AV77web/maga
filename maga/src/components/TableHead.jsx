//=====================================
//File: RicambiTableHead.jsx
//Componente per la gestione dell'header dell
//tabella in Ricambi Manager del componente
//RicambiManagerDialog.jsx
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//=====================================

import React from "react";

const TableHead = ({
  columns,
  areAllCurrentPageRowsSelected,
  onSelectAllCurrentPageRowsChange,
  sortKey,
  sortOrder,
  onSort,
  /*
   * Colonne attualmente attive per la ricerca (array di key).
   */
  activeSearchFields = [],
  /*
   * Callback invocata al click sull'icona di ricerca. Deve togglare lo stato
   * della colonna (aggiungere se non presente, rimuovere se già presente).
   */
  onToggleSearchField = () => {},
}) => {
  return (
    <thead>
      <tr>
        <th>
          <input
            type="checkbox"
            checked={areAllCurrentPageRowsSelected}
            onChange={(e) => onSelectAllCurrentPageRowsChange(e.target.checked)}
            title="Seleziona/Deseleziona tutto in questa pagina"
          />
        </th>
        {columns.map(({ key, label }) => (
          <th key={key} onClick={() => onSort(key)} className="sortable">
            {/* Label */}
            {label}

            {/* Sort indicator */}
            {sortKey === key && (sortOrder === "asc" ? " ▲" : " ▼")}

            {/* Dynamic search icon */}
            <span
              role="button"
              title={`Imposta ricerca su "${label}"`}
              onClick={(e) => {
                // Evita che il click sull'icona scateni l'ordinamento della colonna
                e.stopPropagation();
                onToggleSearchField(key);
              }}
              style={{
                cursor: "pointer",
                marginLeft: "4px",
                userSelect: "none",
                color: activeSearchFields.includes(key) ? "#0d6efd" : "inherit", // blu bootstrap se attivo
              }}
            >
              🔍
            </span>
          </th>
        ))}
      </tr>
    </thead>
  );
};

export default TableHead;
