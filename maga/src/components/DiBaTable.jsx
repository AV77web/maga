//==============================================
//File: DiBaTable.jsx
//Componente per la gestione della distinta base
//(Bill of Material=BOM) degli articoli
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-13"
//==============================================

import React, { useState, useMemo,useEffect,useCallback } from 'react';
import TableGrid from './TableGrid';
import DialogCustom from './DialogCustom';
import Pagination from './Pagination1';
import Header from './Header';
import dibaApi from '../api/dibaApi'; // IPOTETICO: API per la distinta base
import { Droppable } from '@hello-pangea/dnd';
import "../css/ArticoliTable.css"; // Potrebbe servire un CSS specifico

const rowsPerPageOptions = [5, 10, 20, 50]; // Corretto nome variabile

// Props: ricambioPadre, onClose
export default function DiBaTable({ ricambioPadre, onClose, droppedArticle, onDropProcessed }) {
  const [diba, setDiBa] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    id_father:"",
    father_name:"",
    id_son:"",
    son_name:"",
    quantita: "", // Corretto nome campo
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState("");
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [selectedIds, setSelectedIds] = useState([]);
  const [sortKey, setSortKey] = useState("id_son"); // Default sort key
  const [sortOrder, setSortOrder] = useState("asc");
  const [totalCount, setTotalCount] = useState(0);
  const [totalPages, setTotalPages] = useState(1);
  
  const toggleSort = (key) => {
    if (key === sortKey) {
      setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortOrder("asc");
    }
    setPage(0);
  };

  const fetchDiBaForFather = useCallback(async () => {
    if (!ricambioPadre || !ricambioPadre.id) {
      setDiBa([]);
      setTotalCount(0);
      return;
    }
    try {
      setLoading(true);
      setMessage("");

      const queryParams = {
        page: page + 1,
        page_size: rowsPerPage,
        order_by: sortKey,
        order_dir: sortOrder,
      };

      const res = await dibaApi.fetchByFatherId(ricambioPadre.id, queryParams);

      if (!res || !res.rows) {
        console.warn("Risposta non valida della distinta base:", res);
        setMessage("⚠️ Dati della distinta base non validi o mancanti.");
        setDiBa([]);
        setTotalCount(0);
        return;
      }

      const cleanDiBa = res.rows.map((item) => ({
        id: Number(item.id),
        id_father: Number(item.id_father),
        id_son: Number(item.id_son),
        quantita: Number(item.quantita),
        son_name: item.son_name || "N/D",
        son_description: item.son_description || "N/D",
      }));

      setDiBa(cleanDiBa);
      const total = res.meta?.totalRows || cleanDiBa.length;
      setTotalCount(total);
      setTotalPages(Math.max(1, Math.ceil(total / rowsPerPage)));
    } catch (err) {
      console.error("Errore nel caricamento della distinta base:", err);
      setMessage(`❌ Errore caricamento distinta base: ${err.message || "Errore sconosciuto"}`);
      setDiBa([]);
      setTotalCount(0);
    } finally {
      setLoading(false);
    }
  }, [ricambioPadre, page, rowsPerPage, sortKey, sortOrder]);

  useEffect(() => {
    fetchDiBaForFather();
  }, [fetchDiBaForFather]);

  // Effetto per gestire il rilascio di un articolo
  useEffect(() => {
    if (droppedArticle) {
      // Pre-compila e apri il form
      setFormData({
        id: "",
        id_father: ricambioPadre?.id || "",
        father_name: ricambioPadre?.name || "" ,
        id_son: droppedArticle.id,
        son_name: droppedArticle.name,
        quantita: "1", // Imposta una quantità di default
      });
      setIsEditing(false);
      setFormVisible(true);
      setMessage(`Aggiungi il componente "${droppedArticle.name}" (ID: ${droppedArticle.id})`);
      
      // Resetta lo stato nel genitore per evitare ri-trigger
      onDropProcessed();
    }
  }, [droppedArticle, onDropProcessed, ricambioPadre]);
   
  const currentTableData = diba; // dati già paginati dal backend

  const handleNew = useCallback(() => {
    setFormData({
      id: "", // ID vuoto per nuovi record
      id_father: ricambioPadre ? ricambioPadre.id : "",
      id_son: "",
      quantita: "",
    });
    setIsEditing(false);
    setFormVisible(true);
    setMessage("");
  }, [ricambioPadre]);

  const isFormValid = () => {
    const { id_son, quantita } = formData;
    if (!id_son || !quantita) {
      return { isValid: false, error: "ID Articolo Figlio e Quantità sono obbligatori." };
    }
    if (isNaN(Number(id_son)) || isNaN(Number(quantita))) {
      return { isValid: false, error: "ID Articolo Figlio e Quantità devono essere numeri validi." };
    }
    if (Number(quantita) <= 0) {
      return { isValid: false, error: "La quantità deve essere maggiore di zero." };
    }
    if (Number(id_son) === ricambioPadre.id) {
      return { isValid: false, error: "Un articolo non può essere componente di se stesso." };
    }
    return { isValid: true, error: null };
  };

  const handleSubmit = useCallback(async () => {
    const { isValid, error } = isFormValid();
    if (!isValid) {
      setMessage(`❌ Errore di validazione: ${error}`);
      return;
    }

    setIsSubmitting(true);
    setLoading(true);
    setMessage("Salvataggio in corso...");

    // Converte i valori in numeri prima di inviarli
    const dataToSubmit = {
      ...formData,
      id_father: ricambioPadre.id,
      id_son: Number(formData.id_son),
      quantita: Number(formData.quantita),
    };

    try {
      if (isEditing) {
        await dibaApi.update(formData.id, dataToSubmit);
      } else {
        // Rimuovi l'ID per l'inserimento, sarà generato dal backend
        const { id, ...insertData } = dataToSubmit;
        await dibaApi.insert(insertData);
      }
      setMessage(isEditing ? "✅ Componente aggiornato con successo!" : "✅ Componente aggiunto con successo!");
      fetchDiBaForFather(); // Ricarica i dati per il padre corrente
      setFormVisible(false);
      setIsEditing(false);
    } catch (err) {
      console.error("Errore nel salvataggio del componente della distinta base:", err);
      setMessage(`❌ Errore nel salvataggio: ${err.response?.data?.message || err.message || "Errore sconosciuto"}`);
    } finally {
      setIsSubmitting(false);
      setLoading(false);
    }
  }, [fetchDiBaForFather, formData, isEditing, ricambioPadre]);

  const handleEdit = useCallback((item) => {
    setFormData({ // Ensure id_father is always from ricambioPadre for consistency
      id: item.id,
      id_father: ricambioPadre.id, // Dovrebbe essere ricambioPadre.id
      id_son: item.id_son,
      quantita: item.quantita,
    });
    setIsEditing(true);
    setFormVisible(true);
    setMessage("");
  }, [ricambioPadre]);

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
  }, [currentTableData]);

  const handleChange = useCallback((e) => {
    const { name, value } = e.target;
    // Impedisci la modifica di id_father se è precompilato
    if (name === "id_father" && ricambioPadre && ricambioPadre.id) {
        return;
    }
    setFormData((prev) => ({ ...prev, [name]: value }));
  }, [ricambioPadre]);

  const handleDelete = useCallback(async (idToDelete) => {
    // Se idToDelete è un array (da Header), gestisci multipli. Altrimenti singolo.
    const idsArray = Array.isArray(idToDelete) ? idToDelete : [idToDelete];
    if (idsArray.length === 0) return;

    const confirmMessage = idsArray.length === 1
      ? "Sei sicuro di voler eliminare questo componente della distinta base?"
      : `Sei sicuro di voler eliminare ${idsArray.length} componenti della distinta base?`;

    if (!window.confirm(confirmMessage)) return;

    setLoading(true);
    setMessage("Eliminazione in corso...");
    let successCount = 0;
    try {
      for (const id of idsArray) {
        await dibaApi.delete(id);
        successCount++;
      }
      setMessage(`✅ ${successCount} componente/i eliminato/i con successo!`);
      fetchDiBaForFather(); // Corretto nome funzione
      setSelectedIds(prev => prev.filter(selId => !idsArray.includes(selId)));
    } catch (err) {
      console.error("Errore nell'eliminazione:", err);
      setMessage(`❌ Errore eliminazione: ${err.message || "Errore sconosciuto"}. ${successCount} su ${idsArray.length} eliminati.`);
    } finally {
      setLoading(false);
    }
  }, [fetchDiBaForFather]);

  const tableColumns = useMemo(() => [
    { key: "id", label: "ID Riga", cellClassName: "text-center" },
    { key: "id_son", label: "Articolo Figlio ID", cellClassName: "text-left" },
    { key: "son_name", label: "Nome Art. Figlio", cellClassName: "text-left", headerClassName: "col-name" },
    { key: "son_description", label: "Descr. Art Figlio", cellClassName: "text-left", headerClassName: "col-description" },
    { key: "quantita", label: "Quantità", cellClassName: "text-right" }
  ], []);

  // ... altre importazioni e state ...

  const handleRowClick = useCallback((rowId) => {
    setSelectedIds((prevSelectedIds) => {
      const currentSelectedIds = new Set(prevSelectedIds);
      if (currentSelectedIds.has(rowId)) {
        currentSelectedIds.delete(rowId); // Deseleziona se già selezionata
      } else {
        currentSelectedIds.add(rowId);    // Seleziona se non selezionata
      }
      return Array.from(currentSelectedIds);
    });
  }, []);

return (
  <>
    {/*<Header
      onAdd={handleNew}
      onBack={onClose}
      onEdit={() => {
        console.log("[Header onEdit] Triggered. Current selectedIds:", selectedIds);
        if (selectedIds.length === 0) {
          alert("Seleziona un componente da modificare.");
          return;
        }
        if (selectedIds.length > 1) {
          alert("Puoi modificare solo un componente alla volta dall'intestazione.");
          return;
        }
        const itemToEdit = diba.find((item) => item.id === selectedIds[0]);
        if (itemToEdit) {
          handleEdit(itemToEdit);
          setSelectedIds([]);
        } else {
          alert("Il componente selezionato non è stato trovato.");
          setSelectedIds([]);
        }
      }}
      onDelete={() => {
        console.log("[Header onDelete] Triggered. Current selectedIds:", selectedIds);
        if (selectedIds.length === 0) {
          alert("Seleziona almeno una riga da eliminare.");
          return;
        }
        if (window.confirm(`Confermi l'eliminazione di ${selectedIds.length} element${selectedIds.length > 1 ? 'i' : 'o'} selezionat${selectedIds.length > 1 ? 'i' : 'o'}?`)) {
          handleDelete(selectedIds);
          setSelectedIds([]);
        }
      }}
    /> */}

    <h2 className="diba-title">
      Distinta base per: {ricambioPadre ? ricambioPadre.name : 'N/D'} (ID: {ricambioPadre ? ricambioPadre.id : 'N/D'})
    </h2>
    
    <Droppable droppableId="diba-components" isDropDisabled={formVisible}>
      {(provided, snapshot) => (
        <div
          ref={provided.innerRef}
          {...provided.droppableProps}
          className={`table-panel bom-panel ${snapshot.isDraggingOver && !formVisible ? 'drop-zone-active' : ''}`}
        >

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
              title=""
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
              onRowClick={handleRowClick}
              areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
              onSelectAllCurrentPageRowsChange={handleSelectAllCurrentPageRowsChange}
              sortKey={sortKey}
              sortOrder={sortOrder}
              onSort={toggleSort}
              onEdit={handleEdit}
              onDelete={(id) => handleDelete([id])}
              loading={loading}
              onClearAllSelections={() => setSelectedIds([])}
              areAnyRowsSelected={selectedIds.length > 0}
            />
          </div>

          <div className="pagination-bar">
            <Pagination
              currentPage={page + 1}
              totalPages={totalPages}
              onPageChange={(newPage) => setPage(newPage - 1)}
            />

            <label>
              Elementi per pagina:&nbsp;
              <select
                value={rowsPerPage}
                onChange={(e) => {
                  const newSize = parseInt(e.target.value, 10);
                  setRowsPerPage(newSize);
                  setPage(0);
                  setTotalPages(Math.max(1, Math.ceil(totalCount / newSize)));
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

          {/* Dialog Form */}
          <DialogCustom
            open={formVisible}
            onClose={() => setFormVisible(false)}
            onSubmit={handleSubmit}
            title={isEditing ? "Modifica Componente" : "Nuovo Componente"}
            submitButtonText={isSubmitting ? "Salvataggio..." : isEditing ? "Aggiorna Componente" : "Salva Componente"}
            isSubmitting={isSubmitting}
            className="dialog"
          >
            {/* Articolo Padre */}
            <label htmlFor="id_father">Articolo Padre Id:</label>
            <div className="form-group-inline">
              <input
                id="id_father"
                type="number"
                name="id_father"
                readOnly
                value={formData.id_father}
                className="readonly-id"
              />
              <label htmlFor="id_father">Nome:</label>
              <input
                type="text"
                name="father_name"
                readOnly
                value={formData.father_name}
                className="readonly-name"
              />
            </div>

            {/* Articolo Figlio */}
            <label htmlFor="id_son">Articolo Figlio Id:</label>
            <div className="form-group-inline">
              <input
                id="id_son"
                type="number"
                name="id_son"
                readOnly
                value={formData.id_son}
                className="readonly-id"
              />
               <label htmlFor="son_name">Nome:</label>
              <input type="text" name="son_name" readOnly value={formData.son_name} className="readonly-name" />
            </div>

            {/* Quantità */}
            <label htmlFor="quantita">Quantità:</label>
            <input
              id="quantita"
              type="number"
              name="quantita"
              placeholder="Quantità"
              value={formData.quantita}
              onChange={handleChange}
              required
              min="0"
            />
          </DialogCustom>
          {/* Placeholder per dnd */}
          <div style={{ display: 'none' }}>
            <table>
              <tbody>{provided.placeholder}</tbody>
            </table>
          </div>
        </div>
      )}
    </Droppable>
  </>
);
}