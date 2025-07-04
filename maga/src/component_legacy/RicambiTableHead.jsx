//=====================================
//File: RicambiTabelHead.jsx
//Componente per la gestione dell'header dell 
//tabella in Ricambi Manager del componente
//RicambiManagerDialog.jsx
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-10"
//=====================================

import React from 'react';

const RicambiTableHead = ({
  columns,
  areAllCurrentPageRowsSelected,
  onSelectAllCurrentPageRowsChange,
  sortKey,
  sortOrder,
  onSort,
  onClearAllSelections, // Per il checkbox "Deseleziona tutto"
  areAnyRowsSelected,   // Per lo stato checked del checkbox "Deseleziona tutto"
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
        {/*<th className="actions-header">Azioni</th>
        <th>
          <input
            type="checkbox"
            // Se qualcosa è selezionato, questo checkbox (per deselezionare) può essere "attivato" (non checked)
            // Se nulla è selezionato, è come se fosse già "deselezionato tutto"
            // Un comportamento più intuitivo per "Deseleziona tutto" sarebbe un bottone,
            // ma per replicare un checkbox:
            // checked={!areAnyRowsSelected} // Se true, significa che nulla è selezionato
            // Oppure, se è un'azione per pulire, lo stato checked è meno rilevante:
            checked={false} // Lo manteniamo sempre non spuntato, agisce come un pulsante
            onChange={onClearAllSelections}
            title="Deseleziona tutto"
            disabled={!areAnyRowsSelected} // Disabilitato se non c'è nulla da deselezionare
          />
        </th>*/}
      </tr>
    </thead>
  );
};

export default RicambiTableHead;