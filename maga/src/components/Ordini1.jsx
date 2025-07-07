//============================================================
//File: Ordini.jsx
//Componente per la gestione della pagina Ordini
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-05"
//============================================================

import React, { useState, useCallback, useMemo } from "react";
import HeadDocument from "./HeadDocument2"; // Utilizzo la versione con react-hook-form
import TableGrid from "./TableGrid";
import Header from "./Header";
import "../css/Ordini.css";

const Ordini = ({ currentUser, onLogout, currentLocation }) => {
  // 1. Configurazione per HeadDocument basata sulla tabella `ordini`
  const headConfig = {
    titolo: "Dati Ordine Fornitore",
    fields: [
      {
        name: "num_ordine",
        label: "Numero Ordine",
        type: "text",
        required: true,
        placeholder: "Es. 2025/001",
      },
      {
        name: "data_ordine",
        label: "Data Ordine",
        type: "date",
        required: true,
      },
      {
        name: "fornitore_id",
        label: "Fornitore",
        type: "select",
        required: true,
        api: "http://localhost:3001/api/fornitori",
      },
      {
        name: "stato",
        label: "Stato",
        type: "select",
        options: ["APERTO", "INVIATO", "CHIUSO", "ANNULLATO"],
        required: true,
      },
      {
        name: "note",
        label: "Note",
        type: "textarea",
        placeholder: "Inserisci eventuali note...",
      },
    ],
  };

  // 2. Gestione dello stato per testa e righe
  const [headData, setHeadData] = useState({});
  const [rows, setRows] = useState([]);
  const [selectedRowIds, setSelectedRowIds] = useState([]);
  const [nextRowId, setNextRowId] = useState(1); // Per ID temporanei lato client

  // 3. Handler per le modifiche
  const handleHeadChange = useCallback((data) => {
    setHeadData(data);
  }, []);

  const handleAddNewRow = useCallback(() => {
    const newRow = {
      id: `temp_${nextRowId}`, // ID temporaneo per le nuove righe
      id_riga: null,
      cod_articolo: "",
      descrizione: "",
      qta: 1,
      prezzo_unitario: 0,
      totale_riga: 0,
    };
    setRows((prevRows) => [...prevRows, newRow]);
    setNextRowId((prevId) => prevId + 1);
  }, [nextRowId]);

  const handleDeleteSelectedRows = useCallback(() => {
    if (selectedRowIds.length === 0) {
      alert("Selezionare almeno una riga da eliminare.");
      return;
    }
    if (
      window.confirm(
        `Confermi l'eliminazione di ${selectedRowIds.length} righe?`
      )
    ) {
      setRows((prevRows) =>
        prevRows.filter((row) => !selectedRowIds.includes(row.id))
      );
      setSelectedRowIds([]);
    }
  }, [selectedRowIds]);

  const handleRowUpdate = useCallback((rowId, field, value) => {
    setRows((prevRows) =>
      prevRows.map((row) => {
        if (row.id === rowId) {
          const updatedRow = { ...row, [field]: value };
          // Ricalcola il totale se qta o prezzo cambiano
          if (field === "qta" || field === "prezzo_unitario") {
            const qta = parseFloat(updatedRow.qta) || 0;
            const prezzo = parseFloat(updatedRow.prezzo_unitario) || 0;
            updatedRow.totale_riga = qta * prezzo;
          }
          return updatedRow;
        }
        return row;
      })
    );
  }, []);

  const handleSaveOrder = useCallback(() => {
    // Qui si dovrebbe validare e inviare i dati al backend
    console.log("Salvataggio Ordine:");
    console.log("Testa:", headData);
    console.log("Righe:", rows);
    alert("Ordine salvato! (Controlla la console)");
  }, [headData, rows]);

  // Handler per i pulsanti dell'Header
  const handleEditOrder = () => {
    alert("Funzione di modifica dell'ordine non ancora implementata.");
  };

  const handleSeardhOrder = () => {
    alert("Funzione di ricerca dell'ordine non ancora implementata.");
  };

  // 4. Colonne per TableGrid con input modificabili
  const rowsColumns = useMemo(
    () => [
      {
        key: "cod_articolo",
        label: "Cod. Articolo",
        render: (row) => (
          <input
            type="text"
            value={row.cod_articolo}
            onChange={(e) =>
              handleRowUpdate(row.id, "cod_articolo", e.target.value)
            }
            className="editable-cell-input"
          />
        ),
      },
      {
        key: "descrizione",
        label: "Descrizione",
        render: (row) => (
          <input
            type="text"
            value={row.descrizione}
            onChange={(e) =>
              handleRowUpdate(row.id, "descrizione", e.target.value)
            }
            className="editable-cell-input"
          />
        ),
      },
      {
        key: "qta",
        label: "Q.tà",
        cellClassName: "text-right",
        render: (row) => (
          <input
            type="number"
            value={row.qta}
            onChange={(e) => handleRowUpdate(row.id, "qta", e.target.value)}
            className="editable-cell-input text-right"
            step="0.01"
          />
        ),
      },
      {
        key: "prezzo_unitario",
        label: "Prezzo",
        cellClassName: "text-right",
        render: (row) => (
          <input
            type="number"
            value={row.prezzo_unitario}
            onChange={(e) =>
              handleRowUpdate(row.id, "prezzo_unitario", e.target.value)
            }
            className="editable-cell-input text-right"
            step="0.01"
          />
        ),
      },
      {
        key: "totale_riga",
        label: "Totale",
        cellClassName: "text-right",
        render: (row) => (
          <span>{parseFloat(row.totale_riga).toFixed(2)} €</span>
        ),
      },
    ],
    [handleRowUpdate]
  );

  // Handler per la selezione delle righe
  const handleRowSelectionChange = useCallback((id, checked) => {
    setSelectedRowIds((prev) =>
      checked ? [...prev, id] : prev.filter((selId) => selId !== id)
    );
  }, []);

  const areAllCurrentPageRowsSelected = useMemo(
    () =>
      rows.length > 0 && rows.every((row) => selectedRowIds.includes(row.id)),
    [rows, selectedRowIds]
  );

  const handleSelectAllCurrentPageRowsChange = useCallback(
    (checked) => {
      setSelectedRowIds(checked ? rows.map((row) => row.id) : []);
    },
    [rows]
  );

  return (
    <div className="ordini-container">
      <Header
        onEditOrder={handleEditOrder}
        onSearchOrder={handleSeardhOrder}
        currentUser={currentUser}
        onLogout={onLogout}
        currentLocation={currentLocation}
      />

      <div className="ordini-actions-header">
        <h1>Gestione Ordini</h1>
        <button onClick={handleSaveOrder} className="btn-save">
          Salva Ordine
        </button>
      </div>

      <HeadDocument
        config={headConfig}
        onChange={handleHeadChange}
        className="doc-header"
      />

      <div className="ordini-righe-container">
        <h2>Righe Ordine</h2>
        <div className="righe-actions">
          <button onClick={handleAddNewRow}>Aggiungi Riga</button>
          <button
            onClick={handleDeleteSelectedRows}
            disabled={selectedRowIds.length === 0}
          >
            Elimina Selezionate
          </button>
        </div>
        <TableGrid
          columns={rowsColumns}
          rows={rows}
          selectedIds={selectedRowIds}
          onRowSelectionChange={handleRowSelectionChange}
          areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
          onSelectAllCurrentPageRowsChange={
            handleSelectAllCurrentPageRowsChange
          }
          onSort={() => {}}
          sortKey={""}
          sortOrder="asc"
          loading={false} // Non carichiamo dati da un server in questo esempio
        />
      </div>
    </div>
  );
};

export default Ordini;
