//========================================
//File:RicambiManagerDialog4.jsx
//Componente per la gestione dei ricambi.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-10"
//========================================

import React, { useEffect, useState, useMemo, useCallback } from "react";
import axios from "axios";
import Pagination from "./Pagination1";
import RicambiDialogCustom from "./RicambiDialogCustom";
import "../css/RicambiManager.css";
import Header from "./Header";
import ricambiApi from "../api/ricambiApi";
import RicambiTableHead from "./RicambiTableHead";
import RicambiTableBody from "./RicambiTableBody"


const API_BASE = "http://localhost:3001/api/ricambi";

const rowsPerPageOptions = [5, 10, 20, 50];

export default function RicambiManagerDialog4() {
  const [ricambi, setRicambi] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
    quantita: "",
    min: "",
    max: "",
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [selectedIds, setSelectedIds] = useState([]);
  const [sortKey, setSortKey] = useState("name");
  const [sortOrder, setSortOrder] = useState("asc");

  const toggleSort = (key) => {
    if (key === sortKey) {
      setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortOrder("asc");
    }
    setPage(0);
  };

  const fetchRicambi = useCallback(async () => {
    try {
      setLoading(true); // Assicurati che loading sia true all'inizio
      const res = await ricambiApi.fetchAll(`${API_BASE}`);

      // --- LOG DI DEBUG ---
      //console.log("DEBUG: Oggetto 'res' completo da ricambiApi.fetchAll:", res);
      //console.log("DEBUG: Valore di 'res.data':", res.data);
      //console.log("DEBUG: typeof res.data:", typeof res.data);
      // --- FINE LOG DI DEBUG ---

      // Correzione: Accedi direttamente a res.success e res.data
      if (!res || res.success !== true || !Array.isArray(res.data)) {
        console.warn("Risposta non valida del server o dati mancanti:", res);
        setRicambi([]);
        return;
      }
      const cleanRicambi = res.data.map((item) => ({ // Correzione: usa res.data per il map
        id: Number(item.id),
        name: String(item.name).trim(),
        description: String(item.description || "").trim(),
        quantita: Number(item.quantita),
        min: Number(item.min),
        max: Number(item.max),
      }));

      setRicambi(cleanRicambi);
    } catch (err) {
      console.error("Errore nel recupero dei dati (blocco catch):", err);
      setRicambi([]);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchRicambi();
  }, [fetchRicambi]);

  const sortedRicambi = useMemo(() => {
    const sorted = [...ricambi].sort((a, b) => {
      const valA = a[sortKey];
      const valB = b[sortKey];

      if (typeof valA === "string" && typeof valB === "string") {
        return sortOrder === "asc"
          ? valA.localeCompare(valB)
          : valB.localeCompare(valA);
      }

      if (typeof valA === "number" && typeof valB === "number") {
        return sortOrder === "asc" ? valA - valB : valB - valA;
      }

      return 0; // fallback: se i tipi non corrispondono o sono uguali
    });

    return sorted;
  }, [ricambi, sortKey, sortOrder]);

  const currentTableData = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return sortedRicambi.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, sortedRicambi]);

  const handleDelete = useCallback(
    async (id) => {
      if (!window.confirm("Confermi l'eliminazione?")) return;
      setLoading(true);
      try {
        setMessage("Eliminazione in corso...");
        await ricambiApi.delete(`${API_BASE}/${id}`);

        fetchRicambi();
        setMessage("Elemento eliminato con successo!");
      } catch (err) {
        console.error("Errore durante l'eliminazione", err);
        setMessage("Errore durante l'eliminazione");
      } finally {
        setLoading(false);
      }
    },
    [fetchRicambi]
  );

  const handleEdit = useCallback((item) => {
    setFormData(item);
    setIsEditing(true);
    setFormVisible(true);
  }, []);

  const handleNew = useCallback(() => {
    setFormData({
      id: "",
      name: "",
      description: "",
      quantita: "",
      min: "",
      max: "",
    });
    setIsEditing(false);
    setFormVisible(true);
  }, []);

  // Logica per il checkbox "seleziona/deseleziona tutto in questa pagina"
  const areAllCurrentPageRowsSelected = useMemo(() => {
    return currentTableData.length > 0 && currentTableData.every((row) => selectedIds.includes(row.id));
  }, [currentTableData, selectedIds]);

  const handleSelectAllCurrentPageRowsChange = useCallback((checked) => {
    const currentPageIds = currentTableData.map(row => row.id);
    if (checked) {
      setSelectedIds(prev => [...new Set([...prev, ...currentPageIds])]);
    } else {
      setSelectedIds(prev => prev.filter(id => !currentPageIds.includes(id)));
    }
  }, [currentTableData, setSelectedIds]);

  const handleChange = useCallback((e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  }, []);

  const isFormValid = () => {
    if (!formData.name.trim()) return false;
    if (isNaN(Number(formData.quantita)) || Number(formData.quantita) < 0)
      return false;
    return true;
  };

  const handleSubmit = useCallback(async () => {
    if (!isFormValid()) {
      alert("Compila correttamente il form.");
      return;
    }

    setLoading(true);
    setIsSubmitting(true);
    setMessage("Salvataggio in corso...");

    try {
      if (isEditing) {
        //PUT aggiorna
        await ricambiApi.update(`${API_BASE}/${url}`, formData);
      } else {
        // POST inserisci nuovo ricambio
        await ricambiApi.insert(`${API_BASE}`, formData);
      }

      fetchRicambi();
      setFormVisible(false);
      setMessage("Salvato con successo");
    } catch (err) {
      console.error("Errore nel salvataggio", err);
      setMessage("Errore durante il salvataggio");
    } finally {
      setLoading(false);
      setIsSubmitting(false);
    }
  }, [fetchRicambi, formData, isEditing]);

    const tableColumns = useMemo(() => [
    { key: "id", label: "ID" },
    { key: "name", label: "Nome" },
    { key: "description", label: "Descrizione" },
    { key: "quantita", label: "Quantità" },
    { key: "min", label: "Minimo" },
    { key: "max", label: "Massimo" },
  ], []);

  return (
    <>
      <Header
        onAdd={handleNew}
        onEdit={() => {
          console.log(selectedIds);
          if (selectedIds.length === 0) {
            alert("Seleziona un ricambio da modificare");
            return;
          }
          const itemToEdit = ricambi.find((r) => r.id === selectedIds[0]);
          if (itemToEdit) {
            handleEdit(itemToEdit);
            setSelectedIds([]);
          }
        }}
        onDelete={() => {
          if (selectedIds.length === 0) {
            alert("Seleziona almeno una riga da eliminare.");
            return;
          }
          selectedIds.forEach((id) => handleDelete(id));
          setSelectedIds([]); // reset selezione
        }}
      />

      <div className="container">
        <h1>Ricambi Manager</h1>
       {/*<button
          className="btn-add"
          onClick={handleNew}
          aria-label="Aggiungi nuovo ricambio"
        >
          <span style={{ color: "white", fontSize: "28px" }}>+</span>Aggiungi
          Ricambio
        </button>*/}

        {message && <div className="message-info">{message}</div>}

        <div className="table-wrapper">
          <table className="ricambi-table">
            <RicambiTableHead
              columns={tableColumns}
              areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
              onSelectAllCurrentPageRowsChange={handleSelectAllCurrentPageRowsChange}
              sortKey={sortKey}
              sortOrder={sortOrder}
              onSort={toggleSort}
              onClearAllSelections={() => setSelectedIds([])} // Corretto da setSelectedIds(null)
              areAnyRowsSelected={selectedIds.length > 0}
            />
            <RicambiTableBody
              rows={currentTableData}
              selectedIds={selectedIds}
              onRowSelectionChange={(id, checked) => {
                if (checked) {
                  setSelectedIds((prev) => [...prev, id]);
                } else {
                  setSelectedIds((prev) => prev.filter((selId) => selId !== id));
                }
              }}
              onEdit={handleEdit}
              onDelete={handleDelete}
              loading={loading}
              colSpan={tableColumns.length + 2} // 1 per checkbox selezione + numero colonne dati + 1 per azioni
            />
          </table>
        </div>

        <div className="pagination-bar">
          <Pagination
            currentPage={page + 1}
            totalCount={ricambi.length}
            pageSize={rowsPerPage}
            onPageChange={(newPage) => setPage(newPage - 1)}
          />

          <label>
            Elementi per pagina:&nbsp;
            <select
              value={rowsPerPage}
              onChange={(e) => {
                setRowsPerPage(parseInt(e.target.value, 10));
                setPage(0);
              }}
              disabled={loading}
            >
              {rowsPerPageOptions.map((option) => (
                <option key={option} value={option}>
                  {option}
                </option>
              ))}
            </select>
          </label>
        </div>

        <RicambiDialogCustom
          open={formVisible}
          onClose={() => setFormVisible(false)}
          onSubmit={handleSubmit}
          isEditing={isEditing}
          formData={formData}
          onChange={handleChange}
          bottom="0"
          loading={loading}
        />
      </div>
    </>
  );
}
