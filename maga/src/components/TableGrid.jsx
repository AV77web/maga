//==========================================
//File: TableGrid.jsx
//Componente generico per la visualizzazione di una tabella.
//Utilizza RicambiTableHead per l'intestazione e RicambiTableBody per il corpo.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//===========================================
import React, { useState, useMemo } from "react";
import "../css/TableSearchBar.css";
import TableHead from "./TableHead";
import TableBody from "./TableBody";

const TableGrid = ({
  title,
  columns,
  rows,
  selectedIds,
  onRowSelectionChange,
  onRowClick,
  areAllCurrentPageRowsSelected,
  onSelectAllCurrentPageRowsChange,
  sortKey,
  sortOrder,
  onSort,
  loading,
  onClearAllSelections, // Prop per RicambiTableHead (se implementa la funzionalità)
  areAnyRowsSelected, // Prop per RicambiTableHead (se implementa la funzionalità)
  droppableId, // <-- NUOVA PROP per react-beautiful-dnd
}) => {
  // -----------------------------
  // Ricerca dinamica multi-colonna
  // -----------------------------
  /*
   * fieldFilters è un oggetto:
   *   key   -> nome colonna
   *   value -> stringa di ricerca per quella colonna
   *   Esempio: { codice: 'ABC', descrizione: 'motore' }
   */
  const [fieldFilters, setFieldFilters] = useState({});

  // Toggle colonna per la ricerca
  const handleToggleSearchField = (fieldKey) => {
    setFieldFilters((prev) => {
      // Se la colonna è già presente, la rimuovo
      if (fieldKey in prev) {
        const { [fieldKey]: _, ...rest } = prev; // eslint-disable-line no-unused-vars
        return rest;
      }
      // Altrimenti la aggiungo con query vuota
      return { ...prev, [fieldKey]: "" };
    });
  };

  // Aggiorna query per una colonna
  const handleFilterChange = (fieldKey, value) => {
    setFieldFilters((prev) => ({ ...prev, [fieldKey]: value }));
  };

  // Reset di tutti i filtri
  const clearAllFilters = () => setFieldFilters({});

  // Calcola righe filtrate basandosi sui filtri attivi (AND fra colonne)
  const filteredRows = useMemo(() => {
    const activeKeys = Object.keys(fieldFilters).filter(
      (k) => fieldFilters[k]?.trim() !== ""
    );

    if (activeKeys.length === 0) return rows;

    return rows.filter((row) => {
      return activeKeys.every((key) => {
        const value = row[key];
        if (value === null || value === undefined) return false;
        return value
          .toString()
          .toLowerCase()
          .includes(fieldFilters[key].toLowerCase());
      });
    });
  }, [rows, fieldFilters]);

  // Calcola il colSpan per la riga di "nessun dato" o "caricamento" in RicambiTableBody.
  // 1 (checkbox di selezione) + numero di colonne dati
  const colSpanForBody = columns.length + 1;

  return (
    <>
      <h2>{title}</h2>
      {Object.keys(fieldFilters).length > 0 && (
        <div className="table-search-bar multi">
          {Object.entries(fieldFilters).map(([key, query]) => {
            const label = columns.find((c) => c.key === key)?.label || key;
            return (
              <div key={key} className="filter-item">
                <input
                  type="text"
                  value={query}
                  onChange={(e) => handleFilterChange(key, e.target.value)}
                  placeholder={`Cerca in ${label}`}
                />
                <button
                  className="clear-search-btn"
                  onClick={() => handleToggleSearchField(key)}
                  title="Rimuovi filtro per ${label}"
                >
                  ×
                </button>
              </div>
            );
          })}
          {Object.keys(fieldFilters).length > 1 && (
            <button
              className="clear-search-btn clear-all"
              onClick={clearAllFilters}
              title="Rimuovi tutti i filtri"
            >
              Cancella tutti
            </button>
          )}
        </div>
      )}
      <table className="ricambi-table">
        <TableHead
          columns={columns}
          areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
          onSelectAllCurrentPageRowsChange={onSelectAllCurrentPageRowsChange}
          sortKey={sortKey}
          sortOrder={sortOrder}
          onSort={onSort}
          onClearAllSelections={onClearAllSelections}
          areAnyRowsSelected={areAnyRowsSelected}
          activeSearchFields={Object.keys(fieldFilters)}
          onToggleSearchField={handleToggleSearchField}
        />
        <TableBody
          columns={columns} // Passa le colonne a TableBody
          rows={filteredRows}
          selectedIds={selectedIds}
          onRowSelectionChange={onRowSelectionChange}
          onRowClick={onRowClick} // Passa la prop onRowClick a TableBody
          loading={loading}
          colSpan={colSpanForBody}
          droppableId={droppableId} // <-- Passa la prop a TableBody
        />
      </table>
    </>
  );
};

export default TableGrid;
