//=====================================
//File: RicambiTableHead.jsx
//Componente per la gestione dell'header dell 
//tabella in Ricambi Manager del componente
//RicambiManagerDialog.jsx
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//=====================================

import React from 'react';

const TableHead = ({
  columns,
  areAllCurrentPageRowsSelected,
  onSelectAllCurrentPageRowsChange,
  sortKey,
  sortOrder,
  onSort,
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
          <th
            key={key}
            onClick={() => onSort(key)}
            className="sortable"
          >
            {label}
            {sortKey === key && (sortOrder === 'asc' ? ' ▲' : ' ▼')}
          </th>
        ))}
      </tr>
    </thead>
  );
};

export default TableHead;