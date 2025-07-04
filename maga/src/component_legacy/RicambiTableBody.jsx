// File: c:\maga\maga\src\components\RicambiTableBody.jsx
//==========================================
//File: RicambiTableBody.jsx
//Componente per il corpo della tabella dei ricambi.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//===========================================
import React from 'react';

const RicambiTableBody = ({
  columns, // NUOVA PROP: array di oggetti colonna
  rows,
  selectedIds,
  onRowSelectionChange,
  loading,
  colSpan, // colSpan calcolato da TableGrid
}) => {
  if (loading) {
    return (
      <tbody>
        <tr>
          <td colSpan={colSpan} className="no-data text-center">Caricamento...</td>
        </tr>
      </tbody>
    );
  }

  if (rows.length === 0) {
    return (
      <tbody>
        <tr>
          <td colSpan={colSpan} className="no-data text-center">Nessun ricambio disponibile.</td>
        </tr>
      </tbody>
    );
  }

  return (
    <tbody>
      {rows.map((row) => (
        <tr
          key={row.id}
          className={selectedIds.includes(row.id) ? "selected-row" : ""}
        >
          <td>
            <input
              type="checkbox"
              checked={selectedIds.includes(row.id)}
              onChange={(e) => onRowSelectionChange(row.id, e.target.checked)}
              aria-label={`Seleziona riga ${row.id}`} 
            />
          </td>
          {/* Renderizza dinamicamente le celle in base alle colonne definite */}
          {columns.map((column) => (
            <td
              key={column.key}
              className={column.cellClassName || ''} // Applica classe cella se definita
              title={column.titleAccessor ? column.titleAccessor(row) : row[column.key]?.toString()} // Applica title
            >
              {/* Qui potresti aggiungere un formattatore se necessario: column.formatter ? column.formatter(row[column.key], row) : row[column.key] */}
              {row[column.key]}
            </td>
          ))}
        </tr>
      ))}
    </tbody>
  );
};

export default RicambiTableBody;