//==============================================
//File: DistinatBaseManager.jsx
//Componente per la gestione della distinta base
//(Bill of Material=BOM) degli articoli
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-13"
//==============================================

import React, { useDebugValue, useState, useMemo,useEffect,useCallback } from 'react';
import TableGrid from './TableGrid';
import DialogCustom from './DialogCustom';
import Pagination from './Pagination1';
import Header from './Header';
import "../css/RicambiManager.css"

const rowsPagePageOptions = [ 5, 10, 20 ,50];

export default function DistintaBaseManager() {
  const [diba, setDiBa] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    id_father:"",
    id_son:"",
    quantita:"",
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [Loading, setLoading] = useState(false);
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

const fetchDiBa = useCallback(async () => {
    try {
      setLoading(true); // Imposta loading a true all'inizio
      setMessage(""); // Resetta il messaggio
      const responseData = await dibaApi.fetchAll(); // fetchAll non necessita di argomenti

      // La tua dibaApi.js ritorna direttamente response.data
      // Se il backend invia { success: true, data: [...] }
      // allora responseData sarà quell'oggetto.
      // Se il backend invia direttamente l'array [...], allora responseData sarà l'array.
      // Assumiamo che il backend invii un oggetto con una proprietà 'data' che è l'array.
      // Se dibaApi.fetchAll() già gestisce la struttura {success, data},
      // e ritorna direttamente l'array, allora la condizione sotto va adattata.
      // Dalla definizione di dibaApi.js, request ritorna response.data,
      // quindi 'responseData' è ciò che il server invia nel corpo della risposta.
      // Se il server invia { success: true, data: [...] }, allora la logica qui è corretta.
      // Se il server invia solo l'array [...], allora dovresti controllare Array.isArray(responseData)
      if (!responseData || !Array.isArray(responseData.data)) { // Adattato per la struttura comune
        console.warn("Risposta non valida del server o dati mancanti:", responseData);
        setMessage("⚠️ Dati delle diba non validi o mancanti.");
        setDiBa([]);
        return;
      }
      const cleanDiBa = responseData.data.map((item) => ({ // Usa responseData.data
        id: Number(item.id), // Assicurati di includere l'ID
        id_father: Number(item.id_father),
        id_son: Number(item.id_son),
        quantiita: Number(item.quantita),
      }));
      setDiBa(cleanDiBa,);
    } catch (err) {
      console.error("Errore nel caricamento delle diba:", err);
      setMessage(`❌ Errore caricamento diba: ${err.message || "Errore sconosciuto"}`);
      setDiBa([]); // Resetta in caso di errore
    } finally {
      setLoading(false);
    }
  }, []); // Rimosso punto e virgola extra

  useEffect(() => {
    fetchDiBa();
  }, [fetchDiBa]);

const sortedDiBa = useMemo(() => {
    const sorted = [...diba].sort((a, b) => {
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
  }, [diba, sortKey, sortOrder]);

  const currentTableData = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return sortedDiBa.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, sortedDiBa]);

  const handleNew = useCallback(() => {
    setFormData({ id: null, id_father: null, id_son: null, quantita: null }); // ID a null per nuovi record
    setIsEditing(false);
    setFormVisible(true);
    setMessage("");
  }, []);

  const handleSubmit = useCallback(async () => { // e.preventDefault() non serve se il bottone non è type="submit" in un form

    setIsSubmitting(true);
    setLoading(true); // Potrebbe essere utile anche qui
    setMessage("Salvataggio in corso...");

    try {
      let response;
      if (isEditing) {
        response = await 
        
        dibaApi.update(formData.id, formData);
      } else {
        response = await dibaApi.insert(formData);
      }

      // Assumendo che l'API restituisca un oggetto con { success: true/false, message: "..." }
      // o che lanci un errore gestito da dibaApi.js
      setMessage(isEditing ? "✅ diba aggiornata con successo!" : "✅ diba creata con successo!");
      fetchDiBa();
      setFormData({ id: null, id_father: null, id_son: null, quantita: null, });
      setIsEditing(false);
      setFormVisible(false);
    } catch (err) {
      console.error("Errore nel salvataggio della diba:", err);
      setMessage(`❌ Errore nel salvataggio: ${err.message || "Errore sconosciuto"}`);
    } finally {
      setIsSubmitting(false);
      setLoading(false);
    }
  }, [fetchDiBa, formData, isEditing]);

  const handleEdit = useCallback((diba) => {
    setFormData({
      id: diba.id,
      id_father: diba.id_father,
      id_son: diba.id_son,
      quantita: diba.quantita,  
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
    if (!window.confirm("Sei sicuro di voler eliminare questa distinta base?"))
      return;
    setLoading(true); // Imposta loading per feedback visivo
    setMessage("Eliminazione in corso...");
    try {
      await dibaApi.delete(id); // Passa solo l'ID
      setMessage("✅ Distinta base eliminata con successo!");
      fetchBooom();
      setSelectedIds(prev => prev.filter(selId => selId !== id)); // Rimuovi l'ID selezionato
    } catch (err) {
      console.error("Errore nell'eliminazione della distinta:", err);
      setMessage(`❌ Errore eliminazione: ${err.message || "Errore sconosciuto"}`);
    } finally {
      setLoading(false);
    }
  }, [fetchDiBa] );

  const tableColumns = useMemo(() => [
  { key: "id", label: "ID", cellClassName: "text-center" },
  { key: "id_father" , label: "Articolo padre" , cellClassName: "tex-left" },
  { key: "id_son", label: "Articolo figlio", cellClassName: "text-left" },
  { key: "quamtita", label: "Quantita", cellClassName: "text-left" }
] , []);

  const handleManageBOM = () => {
    if (selectedIds.length !== 1) {
      alert("Seleziona un singolo ricambio per gestirne la distinta base.");
      return;
    }
    const ricambioSelected = ricambi.find(r => r.id === selectedIds[0]);
    if (ricambioSelected) {
      setCurrentRicambioForBOM(ricambioSelected);
      setViewMode("diba");
    } else {
      alert("Ricambio selezionato non trovato.");
    }
  };

return (
  <>
  <Header
    onAdd = {handleNew}
    onEdit={() => {
      console.log("[Header onEdit] Triggered. Current selectedIds:", selectedIds);
      if (selectedIds.length === 0) {
        alert("Seleziona una distinta base da modificare");
        console.log("[Header onEdit] No item selected.");
        return;
      }
      if (selectedIds.length > 1) {
        alert("Puoi modificare solo una distinta base alla volta dall'intestazione. Seleziona una singola riga.");
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
        alert("La distinta base selezionata non è statatrovata. Potrebbe essere stata eliminata o la selezione non è valida.");
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
    onManageBOM={viewMode === "ricambi" ? handleManageBOM : undefined} // Passa la nuova funizione 
    isBOMButtonEnabled={selectedIds.length === 1 && viewMode === "ricambi"} // Condizione per abilitare il pulsante BOM

    />
    <div className="container">
        <h1>Distinta Base Manager</h1>
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
                <label htmlFor="id">id:</label>
                <input
                  id="id"
                  type="number"
                  name="id"
                  placeholder="id"
                  value={formData.id}
                 onChange={handleChange}
                />
                <label htmlFor="id_father">codice articolo padre:</label>
                <input
                  id="id_father"
                  type="number"
                  name="id_father"
                  placeholder="codice articolo padre"
                  value={formData.id_father}
                 onChange={handleChange}
                />
                <label htmlFor="id_son">codice articolo figlio:</label>
                <input
                  id="id_son"
                  type="number"
                  name="id_son"
                  placeholder="codice articolo figlio"
                  value={formData.id_son}
                 onChange={handleChange}
                /> 
                <label htmlFor="quantita">Quantita</label>
                <input
                  id="quantita"
                  type="numberr"
                  name="quantita"
                  placeholder="Quantita"
                  value={formData.tipo}
                  onChange={handleChange}
                />  
              </DialogCustom>
            </div> 


    </>
)

}