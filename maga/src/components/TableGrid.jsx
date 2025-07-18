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
  rows, // Ora riceviamo direttamente le righe da visualizzare
  selectedIds,
  onRowSelectionChange,
  onRowDoubleClick,
  areAllCurrentPageRowsSelected,
  onSelectAllCurrentPageRowsChange,
  sortKey,
  sortOrder,
  onSort,
  loading,
  onClearAllSelections,
  areAnyRowsSelected,
  droppableId,
}) => {
  // Calcola il colSpan per la riga di "nessun dato" o "caricamento".
  const colSpanForBody = columns.length + 1;

  // NOTA: Tutta la logica di filtering (useState, useMemo, etc.) è stata rimossa.
  // Questo componente è ora "dumb" e si limita a renderizzare le righe che riceve.
  // Il filtering è gestito a un livello superiore (negli hooks o nel componente padre)
  // che passa i parametri di ricerca al backend.

  return (
    <>
      <h2>{title}</h2>
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
          // La gestione della UI di ricerca non appartiene più a questo componente
        />
        <TableBody
          columns={columns}
          rows={rows} // Passiamo direttamente le righe ricevute
          selectedIds={selectedIds}
          onRowSelectionChange={onRowSelectionChange}
          onRowDoubleClick={onRowDoubleClick}
          loading={loading}
          colSpan={colSpanForBody}
          droppableId={droppableId}
        />
      </table>
    </>
  );
};

export default TableGrid;
