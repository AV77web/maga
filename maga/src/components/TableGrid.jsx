//==========================================
//File: TableGrid.jsx
//Componente generico per la visualizzazione di una tabella.
//Utilizza RicambiTableHead per l'intestazione e RicambiTableBody per il corpo.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//===========================================
import React from 'react';
import TableHead from './TableHead';
import TableBody from './TableBody';

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
  areAnyRowsSelected,   // Prop per RicambiTableHead (se implementa la funzionalità)
  droppableId,          // <-- NUOVA PROP per react-beautiful-dnd
}) => {
  // Calcola il colSpan per la riga di "nessun dato" o "caricamento" in RicambiTableBody.
  // 1 (checkbox di selezione) + numero di colonne dati
  const colSpanForBody = columns.length + 1;

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
      />
      <TableBody
        columns={columns} // Passa le colonne a TableBody
        rows={rows}
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