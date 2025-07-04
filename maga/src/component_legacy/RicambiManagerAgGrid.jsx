//==============================================
// File: RicambiManagerAgGrid.jsx (definitivo)
// Gestione ricambi con AG-Grid (Community)
//==============================================

import React, { useState, useEffect, useCallback, useMemo } from "react";
import { AgGridReact } from "ag-grid-react";

// ✅ Solo moduli supportati
import {
  ModuleRegistry,
  ClientSideRowModelModule,
  PaginationModule,
} from "ag-grid-community";

// ✅ Registrazione moduli
ModuleRegistry.registerModules([ClientSideRowModelModule, PaginationModule]);

import "ag-grid-community/styles/ag-theme-alpine.css";
import "../css/RicambiManager.min.css";

function RicambiManagerAgGrid() {
  const [ricambi, setRicambi] = useState([]);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
  });

  useEffect(() => {
    fetchRicambi();
  }, []);

  const fetchRicambi = () => {
    fetch("/maga/api/get_ricambi.php")
      .then((res) => res.json())
      .then((data) => setRicambi(data))
      .catch((err) =>
        console.error("Errore nel caricamento dei ricambi:", err)
      );
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const url = formData.id
      ? "/maga/api/update_ricambio.php"
      : "/maga/api/insert_ricambio.php";

    fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(formData),
    })
      .then((res) => res.json())
      .then(() => {
        fetchRicambi();
        setFormData({ id: "", name: "", description: "" });
      })
      .catch((err) =>
        console.error("Errore nella sottomissione del form:", err)
      );
  };

  const handleEdit = useCallback((ricambio) => {
    setFormData(ricambio);
  }, []);

  const handleDelete = useCallback((id) => {
    if (window.confirm("Sei sicuro di voler eliminare questo ricambio?")) {
      fetch("/maga/api/delete_ricambio.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id }),
      })
        .then((res) => res.json())
        .then(() => fetchRicambi())
        .catch((err) => console.error("Errore nella cancellazione:", err));
    }
  }, []);

  const columnDefs = useMemo(
    () => [
      {
        headerName: "ID",
        field: "id",
        sortable: true,
        filter: true,
        width: 80,
      },
      {
        headerName: "Nome",
        field: "name",
        sortable: true,
        filter: true,
      },
      {
        headerName: "Descrizione",
        field: "description",
        sortable: true,
        filter: true,
      },
      {
        headerName: "Azioni",
        cellRendererFramework: (params) => (
          <>
            <button onClick={() => handleEdit(params.data)}>Modifica</button>
            <button onClick={() => handleDelete(params.data.id)}>
              Elimina
            </button>
          </>
        ),
        width: 160,
      },
    ],
    [handleEdit, handleDelete]
  );

  return (
    <div>
      <h2>Gestione Ricambi (AG Grid)</h2>

      <form onSubmit={handleSubmit} className="ricambi-form">
        <input
          type="text"
          name="id"
          placeholder="ID"
          value={formData.id}
          readOnly
        />
        <input
          type="text"
          name="name"
          placeholder="Nome"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <input
          type="text"
          name="description"
          placeholder="Descrizione"
          value={formData.description}
          onChange={handleChange}
          required
        />
        <button type="submit">{formData.id ? "Aggiorna" : "Aggiungi"}</button>
        {formData.id && (
          <button
            type="button"
            onClick={() => setFormData({ id: "", name: "", description: "" })}
          >
            Annulla
          </button>
        )}
      </form>

      <div
        className="ag-theme-alpine"
        style={{ height: 400, width: "100%", marginTop: 20 }}
      >
        <AgGridReact
          rowData={ricambi}
          columnDefs={columnDefs}
          domLayout="autoHeight"
          pagination={true}
          paginationPageSize={10}
        />
      </div>
    </div>
  );
}

export default RicambiManagerAgGrid;
