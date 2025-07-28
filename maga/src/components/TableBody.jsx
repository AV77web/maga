// File: c:\maga\maga\src\components\TableBody.jsx
//============================================================================
//File: TableBody.jsx
//Componente generico per il corpo delle tabelle (articoli, movimenti ecc...).
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//============================================================================
import React from 'react';
import { Droppable, Draggable } from '@hello-pangea/dnd';

const TableBody = ({
  columns, // NUOVA PROP: array di oggetti colonna
  rows,
  selectedIds = [], // Aggiunto valore di default per evitare errori
  onRowSelectionChange,
  onRowClick, // Nuova prop per gestire il click sulla riga
  onRowDoubleClick, // Nuova prop per gestire il doppio click sulla riga
  loading,
  colSpan, // colSpan calcolato da TableGrid
  droppableId, // ID per la zona di rilascio
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

  // Se è un'area draggabile, usa Droppable e Draggable
  if (droppableId) {
    return (
      <Droppable droppableId={droppableId}>
        {(provided) => (
          <tbody ref={provided.innerRef} {...provided.droppableProps}>
            {rows.map((row, index) => (
              <Draggable key={row.id ?? `dnd-row-${index}`} draggableId={(row.id ?? `dnd-row-${index}`).toString()} index={index}>
                {(provided, snapshot) => (
                  <tr
                    ref={provided.innerRef}
                    {...provided.draggableProps}
                    {...provided.dragHandleProps}
                    className={`${selectedIds.includes(row.id) ? "selected-row" : ""} ${snapshot.isDragging ? "dragging-row" : ""}`}
                    style={{ ...provided.draggableProps.style }}
                  >
                    <td key="selection-cell">
                      <input type="checkbox" checked={selectedIds.includes(row.id)} onChange={(e) => onRowSelectionChange(row.id, e.target.checked)} aria-label={`Seleziona riga ${row.id}`} />
                    </td>
                    {columns.map((column) => {
                      let value = column.render ? column.render(row) : row[column.key];
                      // Log e fix per NaN
                      if (typeof value === 'number' && isNaN(value)) {
                        console.warn('NaN detected in column:', column.key, 'row:', row);
                        value = '';
                      }
                      return (
                        <td key={column.key} className={typeof column.cellClassName === 'function' ? column.cellClassName(row) : (column.cellClassName || '')} title={column.titleAccessor ? column.titleAccessor(row) : (value !== undefined && value !== null ? value.toString() : '')}>
                          {value ?? ''}
                        </td>
                      );
                    })}
                  </tr>
                )}
              </Draggable>
            ))}
            {provided.placeholder}
          </tbody>
        )}
      </Droppable>
    );
  }

  // Altrimenti, renderizza un normale tbody non draggabile
  return (
    <tbody>
      {rows.map((row, index) => (
        <tr
          key={row.id ?? `row-${index}`}
          className={selectedIds.includes(row.id) ? "selected-row" : "not-selected-row"}
          onDoubleClick={(e) => { if (onRowDoubleClick && e.target.tagName !== 'INPUT' && e.target.tagName !== 'BUTTON' && !e.target.closest('button')) { onRowDoubleClick(row.id); } }}
          style={{ cursor: onRowDoubleClick ? 'pointer' : 'default' }}
        >
          <td key="selection-cell" style={{ width: '40px', textAlign: 'center' }}>
            <input type="checkbox" checked={selectedIds.includes(row.id)} onChange={(e) => onRowSelectionChange(row.id, e.target.checked)} aria-label={`Seleziona riga ${row.id}`} />
          </td>
          {columns.map((column) => (
            <td key={column.key} className={typeof column.cellClassName === 'function' ? column.cellClassName(row) : (column.cellClassName || '')} title={column.titleAccessor ? column.titleAccessor(row) : row[column.key]?.toString()}>
              {column.render ? column.render(row) : row[column.key]}
            </td>
          ))}
        </tr>
      ))}
    </tbody>
  );
};

export default TableBody;