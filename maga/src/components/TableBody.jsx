// File: c:\maga\maga\src\components\RicambiTableBody.jsx
//==========================================
//File: RicambiTableBody.jsx
//Componente per il corpo della tabella dei ricambi.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-11"
//===========================================
import React from 'react';
import { Droppable, Draggable } from '@hello-pangea/dnd';

const TableBody = ({
  columns, // NUOVA PROP: array di oggetti colonna
  rows,
  selectedIds,
  onRowSelectionChange,
  onRowClick, // Nuova prop per gestire il click sulla riga
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
              <Draggable key={row.id} draggableId={row.id.toString()} index={index}>
                {(provided, snapshot) => (
                  <tr
                    ref={provided.innerRef}
                    {...provided.draggableProps}
                    {...provided.dragHandleProps}
                    className={`${selectedIds.includes(row.id) ? "selected-row" : ""} ${snapshot.isDragging ? "dragging-row" : ""}`}
                    style={{ ...provided.draggableProps.style }}
                  >
                    <td>
                      <input type="checkbox" checked={selectedIds.includes(row.id)} onChange={(e) => onRowSelectionChange(row.id, e.target.checked)} aria-label={`Seleziona riga ${row.id}`} />
                    </td>
                    {columns.map((column) => (
                      <td key={column.key} className={typeof column.cellClassName === 'function' ? column.cellClassName(row) : (column.cellClassName || '')} title={column.titleAccessor ? column.titleAccessor(row) : row[column.key]?.toString()}>
                        {column.render ? column.render(row) : row[column.key]}
                      </td>
                    ))}
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
      {rows.map((row) => (
        <tr
          key={row.id}
          className={selectedIds.includes(row.id) ? "selected-row" : ""}
          onClick={(e) => { if (onRowClick && e.target.tagName !== 'INPUT' && e.target.tagName !== 'BUTTON' && !e.target.closest('button')) { onRowClick(row.id); } }}
          style={{ cursor: onRowClick ? 'pointer' : 'default' }}
        >
          <td>
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