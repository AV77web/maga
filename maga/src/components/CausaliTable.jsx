//=====================================
// File: CausaliTable.jsx
// Descrizione: Gestione delle causali
// per i movimenti di magazzino
// @author: "villari.andrea@libero.it"
// @version: "1.0.0. 2025-06-04"
//=====================================
import React, { useState, useEffect, useMemo, useCallback } from "react";
import axios from "axios";
import causaliApi from "../api/causaliApi";
import DialogCustom from "./DialogCustom";
import Header from "./Header";
import TableGrid from "./TableGrid";
import Pagination from "./Pagination1";
import "../css/CausaliTable.css";

const rowsPerPageOptions = [ 5 , 10, 20, 50];

const API_BASE = "http://localhost:3001/api/causali";

// Definizione delle colonne per la tabella

function CausaliTable() {
  const [causali, setCausali] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    codice: "",
    description: "",
    tipo: "",
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(""); // Inizializza come stringa vuota
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [selectedIds, setSelectedIds] = useState([]);
  const [sortKey, setSortKey] = useState("codice");
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

  const fetchCausali = useCallback(async () => {
    try {
      setLoading(true); // Imposta loading a true all'inizio
      setMessage(""); // Resetta il messaggio
      const responseData = await boomApi.fetchAll(); // fetchAll non necessita di argomenti

      // La tua causaliApi.js ritorna direttamente response.data
      // Se il backend invia { success: true, data: [...] }
      // allora responseData sarà quell'oggetto.
      // Se il backend invia direttamente l'array [...], allora responseData sarà l'array.
      // Assumiamo che il backend invii un oggetto con una proprietà 'data' che è l'array.
      // Se causaliApi.fetchAll() già gestisce la struttura {success, data},
      // e ritorna direttamente l'array, allora la condizione sotto va adattata.
      // Dalla definizione di causaliApi.js, request ritorna response.data,
      // quindi 'responseData' è ciò che il server invia nel corpo della risposta.
      // Se il server invia { success: true, data: [...] }, allora la logica qui è corretta.
      // Se il server invia solo l'array [...], allora dovresti controllare Array.isArray(responseData)
      if (!responseData || !Array.isArray(responseData.data)) { // Adattato per la struttura comune
        console.warn("Risposta non valida del server o dati mancanti:", responseData);
        setMessage("⚠️ Dati delle causali non validi o mancanti.");
        setCausali([]);
        return;
      }
      const cleanCausali = responseData.data.map((item) => ({ // Usa responseData.data
        id: Number(item.id), // Assicurati di includere l'ID
        codice: String(item.codice).trim(),
        description: String(item.description || "").trim(),
        tipo: String(item.tipo || "").trim(),
      }));
      setCausali(cleanCausali);
    } catch (err) {
      console.error("Errore nel caricamento delle causali:", err);
      setMessage(`❌ Errore caricamento causali: ${err.message || "Errore sconosciuto"}`);
      setCausali([]); // Resetta in caso di errore
    } finally {
      setLoading(false);
    }
  }, []); // Rimosso punto e virgola extra

  useEffect(() => {
    fetchCausali();
  }, [fetchCausali]);


  const sortedCausali = useMemo(() => {
    const sorted = [...causali].sort((a, b) => {
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
  }, [causali, sortKey, sortOrder]);

  const currentTableData = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return sortedCausali.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, sortedCausali]);




  const handleNew = useCallback(() => {
    setFormData({ id: null, codice: "", description: "", tipo: "" }); // ID a null per nuovi record
    setIsEditing(false);
    setFormVisible(true);
    setMessage("");
  }, []);

  const handleSubmit = useCallback(async () => { // e.preventDefault() non serve se il bottone non è type="submit" in un form
    if (!formData.codice.trim() || !formData.description.trim() || !formData.tipo.trim()) {
      setMessage("⚠️ Compila tutti i campi obbligatori.");
      return;
    }

    setIsSubmitting(true);
    setLoading(true); // Potrebbe essere utile anche qui
    setMessage("Salvataggio in corso...");

    try {
      let response;
      if (isEditing) {
        response = await causaliApi.update(formData.id, formData);
      } else {
        response = await causaliApi.insert(formData);
      }

      // Assumendo che l'API restituisca un oggetto con { success: true/false, message: "..." }
      // o che lanci un errore gestito da causaliApi.js
      setMessage(isEditing ? "✅ Causale aggiornata con successo!" : "✅ Causale creata con successo!");
      fetchCausali();
      setFormData({ id: null, codice: "", description: "", tipo: "" });
      setIsEditing(false);
      setFormVisible(false);
    } catch (err) {
      console.error("Errore nel salvataggio della causale:", err);
      setMessage(`❌ Errore nel salvataggio: ${err.message || "Errore sconosciuto"}`);
    } finally {
      setIsSubmitting(false);
      setLoading(false);
    }
  }, [fetchCausali, formData, isEditing]);


  const handleEdit = useCallback((causale) => {
    setFormData({
      id: causale.id,
      codice: causale.codice,
      description: causale.description,
      tipo: causale.tipo,
    });
    setIsEditing(true);
    setFormVisible(true);
    setMessage("");
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
      const { name, value } = e.target; // Usa 'name' dall'input
      setFormData((prev) => ({ ...prev, [name]: value }));
    }, []);




  const handleDelete = useCallback (
   async (id) => {
    if (!window.confirm("Sei sicuro di voler eliminare questa causale?"))
      return;
    setLoading(true); // Imposta loading per feedback visivo
    setMessage("Eliminazione in corso...");
    try {
      await causaliApi.delete(id); // Passa solo l'ID
      setMessage("✅ Causale eliminata con successo!");
      fetchCausali();
      setSelectedIds(prev => prev.filter(selId => selId !== id)); // Rimuovi l'ID selezionato
    } catch (err) {
      console.error("Errore nell'eliminazione della causale:", err);
      setMessage(`❌ Errore eliminazione: ${err.message || "Errore sconosciuto"}`);
    } finally {
      setLoading(false);
    }
  }, [fetchCausali] );

  const tableColumns = useMemo(() => [
  { key: "id", label: "ID", cellClassName: "text-center" },
  { key: "codice" , label: "Codice" , cellClassName: "tex-left" },
  { key: "description", label: "Descrizione", cellClassName: "text-left", titleAccessor: (row) => row.description  },
  { key: "tipo", label: "Tipo", cellClassName: "text-left" }
] , []);

  return (
    <>
    <Header
        onAdd={handleNew}
        onEdit={() => {
          console.log("[Header onEdit] Triggered. Current selectedIds:", selectedIds);
          if (selectedIds.length === 0) {
            alert("Seleziona una causale da modificare");
            console.log("[Header onEdit] No item selected.");
            return;
          }
          if (selectedIds.length > 1) {
            alert("Puoi modificare solo una causale alla volta dall'header. Seleziona una singola riga.");
            console.log("[Header onEdit] Multiple items selected for single edit:", selectedIds.length);
            return;
          }
          const itemToEdit = causali.find((r) => r.id === selectedIds[0]);
          if (itemToEdit) {
            console.log("[Header onEdit] Item to edit found:", itemToEdit);
            handleEdit(itemToEdit);
            setSelectedIds([]);
            console.log("[Header onEdit] selectedIds cleared after finding item.");
          } else {
            alert("Causale selezionata non trovata. Potrebbe essere stata eliminata o la selezione non è valida.");
            console.warn("[Header onEdit] Item to edit not found for ID:", selectedIds[0]);
            setSelectedIds([]); 
            console.log("[Header onEdit] selectedIds cleared after item not found.");
          }
        }}
        onDelete={() => {
          console.log("[Header onDelete] Triggered. Current selectedIds:", selectedIds);
          if (selectedIds.length === 0) {
            alert("Seleziona almeno una riga da eliminare.");
            console.log("[Header onDelete] No items selected for deletion.");
            return;
          }
          if (window.confirm(`Confermi l'eliminazione di ${selectedIds.length} element${selectedIds.length > 1 ? 'i' : 'o'} selezionat${selectedIds.length > 1 ? 'i' : 'o'}?`)) {
            console.log("[Header onDelete] Deletion confirmed for IDs:", selectedIds);
            selectedIds.forEach((id) => handleDelete(id));
            setSelectedIds([]); 
            console.log("[Header onDelete] selectedIds cleared after initiating deletions.");
          } else {
            console.log("[Header onDelete] Deletion cancelled by user.");
          }
        }}
    />
      

    <div className="container">
        <h1>Causali Manager</h1>
        {message && (
          <div
            className={`message-info ${
              message.includes("✅") ? "message-success" :
              message.includes("❌") ? "message-error" :
              message.includes("⚠️") ? "message-warning" : ""
            }`}
          >
            {message}
          </div>
        )}

        <div className="table-wrapper">
          <TableGrid
            columns={tableColumns}
            rows={currentTableData}
            selectedIds={selectedIds}
            onRowSelectionChange={(id, checked) => {
              if (checked) {
                setSelectedIds((prev) => [...prev, id]);
              } else {
                setSelectedIds((prev) => prev.filter((selId) => selId !== id));
              }
            }}
            areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
            onSelectAllCurrentPageRowsChange={handleSelectAllCurrentPageRowsChange}
            sortKey={sortKey}
            sortOrder={sortOrder}
            onSort={toggleSort}
            onEdit={handleEdit}
            onDelete={handleDelete}
            loading={loading}
            onClearAllSelections={() => setSelectedIds([])}
            areAnyRowsSelected={selectedIds.length > 0}
          />
        </div>
      
      <div className="pagination-bar">
        <Pagination
            currentPage={page + 1}
            totalCount={causali.length}
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
        <DialogCustom 
          open={formVisible}
          onClose={() => setFormVisible(false)}
          onSubmit={handleSubmit}
          title={isEditing ? "Modifica Causale" : "Nuova Causale"}
          submitButtonText={isSubmitting ? "Salvataggio..." : isEditing ? "Aggiorna Causale" : "Salva Causale"}
          isSubmitting={isSubmitting}
        >
          <label htmlFor="codice">Codice:</label>
          <input
            id="codice"
            type="text"
            name="codice"
            placeholder="Codice"
            value={formData.codice}
           onChange={handleChange}
          />
          <label htmlFor="description">Descrizione:</label>
          <textarea
            id="description"
            type="text"
            name="description"
            placeholder="Descrizione"
            value={formData.description}
            onChange={handleChange}
          /> 
          <label htmlFor="tipo">Tipo:</label>
          <input
            id="tipo"
            type="text"
            name="tipo"
            placeholder="Tipo"
            value={formData.tipo}
            onChange={handleChange}
          />  
        </DialogCustom>
      </div> 
    </>
  );
}

export default CausaliTable;
