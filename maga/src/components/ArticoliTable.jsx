//========================================
//File:ArticoliTable.jsx
//Componente per la gestione dei ricambi.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-10"
//========================================
import React, { useEffect, useState, useMemo, useCallback } from "react";
import DialogCustom from "./DialogCustom";
import DiBaTable from "./DiBaTable";
import DiBaPopover from "./DiBaPopover"; // Importa il nuovo componente Popover
import dibaApi from "../api/dibaApi"; // Importa l'API per la DiBa
import { DragDropContext } from "@hello-pangea/dnd";
import FilterSearch from "./FilterSearch";
import Header from "./Header";
import Pagination from "./Pagination1";
import ricambiApi from "../api/ricambiApi";
import TableGrid from "./TableGrid"; // Importa il nuovo componente TableGrid
import "../css/ArticoliTable.css";

const API_BASE = "http://localhost:3001/api/ricambi";

const rowsPerPageOptions = [5, 10, 20, 50];

export default function ArticoliTable({
  currentUser,
  onLogout,
  currentLocation,
}) {
  // Accetta currentUser
  const [ricambi, setRicambi] = useState([]);
  const [totalCount, setTotalCount] = useState(0); // totale record
  const [totalPages, setTotalPages] = useState(1);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
    quantita: "",
    min: "",
    max: "",
    supplier: "",
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState(""); // Modificato: inizializzato a stringa vuota
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [selectedIds, setSelectedIds] = useState([]);
  const [sortKey, setSortKey] = useState("name");
  const [sortOrder, setSortOrder] = useState("asc");
  const [showSearch, setShowSearch] = useState(false); // Stato per il panello di ricerca
  const [viewMode, setViewMode] = useState("ricambi"); // 'ricambi' o 'bom'
  const [currentRicambioForBOM, setCurrentRicambioForBOM] = useState(null);
  const [droppedArticle, setDroppedArticle] = useState(null); // Stato per l'articolo trascinato
  // Stati per il popover della DiBa
  const [popoverData, setPopoverData] = useState(null); // Stato unificato per i dati del popover
  const [popoverAnchorEl, setPopoverAnchorEl] = useState(null);
  const [popoverLoading, setPopoverLoading] = useState(false);

  const toggleSort = (key) => {
    if (key === sortKey) {
      setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortOrder("asc");
    }
    setPage(0);
  };

  const toggleSearchPanel = () => {
    setShowSearch((prev) => !prev);
  };

  const fetchRicambi = useCallback(async () => {
    try {
      setLoading(true);

      // Parametri per paginazione e ordinamento lato server
      const queryParams = {
        page: page + 1, // la SP usa 1-based index
        page_size: rowsPerPage,
        order_by: sortKey || "name",
        order_dir: sortOrder,
      };

      const res = await ricambiApi.fetchAll(queryParams);

      if (!res || !res.rows) {
        console.warn("Risposta non valida del server:", res);
        setRicambi([]);
        setTotalCount(0);
        return;
      }

      const cleanRicambi = res.rows.map((item) => ({
        id: Number(item.id),
        name: String(item.name).trim(),
        description: String(item.description || "").trim(),
        quantita: Number(item.quantita),
        um: String(item.um || "").trim(),
        prezzo: Number(item.prezzo || 0),
        min: Number(item.min),
        max: Number(item.max),
        supplier: String(item.supplier || "").trim(),
        has_diba: String(item.has_diba || "").trim().toUpperCase(),
      }));

      setRicambi(cleanRicambi);
      const total = res.meta?.totalRows || cleanRicambi.length;
      setTotalCount(total);
      setTotalPages(Math.max(1, Math.ceil(total / rowsPerPage)));
    } catch (err) {
      console.error("Errore nel recupero dei dati:", err);
      setRicambi([]);
      setTotalCount(0);
    } finally {
      setLoading(false);
    }
  }, [page, rowsPerPage, sortKey, sortOrder]);

  useEffect(() => {
    fetchRicambi();
  }, [fetchRicambi]);

  // Con i dati già ordinati/paginati dal backend, non è necessario un ulteriore ordinamento client-side
  const currentTableData = ricambi;

  const handleDelete = useCallback(
    async (id) => {
      if (!window.confirm("Confermi l'eliminazione?")) return;
      setLoading(true);
      try {
        setMessage("Eliminazione in corso...");
        const apiRes = await ricambiApi.delete(id); // Passa solo l'ID

        if (!apiRes) {
          // apiClient dovrebbe restituire un oggetto in caso di successo, quindi questo è un controllo difensivo
          console.warn(
            "Risposta inattesa dal sever per l'operazione si eliminazione:",
            apiRes
          );
          setMessage(
            "Eliminazione completata ma senza una vera risposta valid dal server"
          );
          return;
        }

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
      um: "",
      prezzo: "",
      min: "",
      max: "",
      supplier: "",
    });
    setIsEditing(false);
    setFormVisible(true);
  }, []);

  const handleManageBOM = useCallback(() => {
    if (selectedIds.length === 0) {
      alert("Seleziona un ricambio per gestirne la distinta base.");
      return;
    }
    if (selectedIds.length > 1) {
      alert("Puoi gestire la distinta base di un solo ricambio alla volta.");
      return;
    }
    const ricambioId = selectedIds[0];
    const ricambioSelezionato = ricambi.find((r) => r.id === ricambioId);

    if (ricambioSelezionato) {
      setCurrentRicambioForBOM(ricambioSelezionato);
      setViewMode("bom");
    } else {
      alert("Ricambio selezionato non trovato. Prova a ricaricare i dati.");
    }
  }, [selectedIds, ricambi, setViewMode, setCurrentRicambioForBOM]);

  // Gestione del popover della DiBa
  const handleDibaIconClick = async (event, row) => {
    // Se si clicca sulla stessa icona, chiude il popover (ora controlliamo l'ID dell'articolo nei dati)
    if (popoverData?.article?.id === row.id) {
      handlePopoverClose();
      return;
    }

    setPopoverAnchorEl(event.currentTarget);
    setPopoverData({ article: row, components: [] }); // Imposta l'articolo, i componenti sono vuoti inizialmente
    setPopoverLoading(true);

    try {
      const res = await dibaApi.fetchByFatherId(row.id, {
        page: 1,
        page_size: 100, // recupera fino a 100 componenti, di solito bastano
        order_by: "id_son",
        order_dir: "ASC",
      });

      const components = res && res.rows ? res.rows : Array.isArray(res) ? res : [];

      setPopoverData((prevData) => ({ ...prevData, components }));
    } catch (error) {
      console.error("Errore nel recupero dei componenti della DiBa:", error);
      setPopoverData((prevData) => ({ ...prevData, components: [] }));
    } finally {
      setPopoverLoading(false);
    }
  };

  const handlePopoverClose = () => {
    setPopoverAnchorEl(null);
    setPopoverData(null); // Resetta lo stato unificato
  };

  // Logica per il checkbox "seleziona/deseleziona tutto in questa pagina"
  const areAllCurrentPageRowsSelected = useMemo(() => {
    return (
      currentTableData.length > 0 &&
      currentTableData.every((row) => selectedIds.includes(row.id))
    );
  }, [currentTableData, selectedIds]);

  const handleSelectAllCurrentPageRowsChange = useCallback(
    (checked) => {
      const currentPageIds = currentTableData.map((row) => row.id);
      if (checked) {
        setSelectedIds((prev) => [...new Set([...prev, ...currentPageIds])]);
      } else {
        setSelectedIds((prev) =>
          prev.filter((id) => !currentPageIds.includes(id))
        );
      }
    },
    [currentTableData, setSelectedIds]
  );

  const handleChange = useCallback((e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  }, []);

  const isFormValid = () => {
    if (!formData.name.trim()) return false;
    if (isNaN(Number(formData.quantita)) || Number(formData.quantita) < 0) {
      return false;
    }
    if (isNaN(Number(formData.prezzo)) || Number(formData.prezzo) < 0) {
      return false;
    }
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
      let apiRes; // introduco la variabile apiRes per catturare il risultato
      // della chiamata .update e .insert per poi aggiungere un controllo if(!apiRes).
      // Se apiRes è null o undefined mostra un avviso in console e all'utente)
      if (isEditing) {
        //PUT aggiorna
        //await ricambiApi.update(formData.id, formData);
        apiRes = await ricambiApi.update(formData.id, formData);
      } else {
        // POST inserisci nuovo ricambio
        //await ricambiApi.insert(formData);
        apiRes = await ricambiApi.insert(formData);
      }
      if (!apiRes) {
        // apiClientFactory dovrebbe già prevenire ciò e restituire un oggetto solo in caso di successo,
        // quindi questo è un  controllo difensivo.
        console.warn(
          "Risposta inattesa dal server per le operazioni di salvataggio",
          apiRes
        );
        setMessage(
          "Operazione completata ma senza un vera risposta valida dal server."
        );
        return;
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

  const tableColumns = useMemo(() => {
    const allColumns = [
      {
        key: "diba_icon",
        label: "", // Nessuna etichetta per la colonna
        cellClassName: "text-center",
        headerClassName: "col-icon",
        render: (row) => {
          if (row.has_diba === "S") {
            return (
              <span
                style={{
                  color: "green",
                  fontWeight: "bold",
                  cursor: "pointer",
                  fontSize: "1.8em",
                }}
                title="Questo articolo ha una distinta base"
                onClick={(event) => handleDibaIconClick(event, row)}
              >
                +
              </span>
            );
          }
          if (row.has_diba === "N") {
            return (
              <span
                style={{
                  color: "red",
                  fontWeight: "bold",
                  cursor: "default",
                  fontSize: "1.8em",
                }}
                title="Questo articolo non ha una distinta base"
              >
                -
              </span>
            );
          }
          return null;
        },
      },
      { key: "id", label: "ID", cellClassName: "text-center" },
      {
        key: "name",
        label: "Nome",
        cellClassName: "name-cell",
        headerClassName: "col-name",
        titleAccessor: (row) => row.name,
      },
      {
        key: "description",
        label: "Descrizione",
        cellClassName: "description-cell",
        headerClassName: "col-description",
        titleAccessor: (row) => row.description,
      },
      { key: "quantita", label: "Quantità", cellClassName: "text-right" },
      { key: "um", label: "UM", cellClassName: "text-left" },
      { key: "prezzo", label: "Prezzo", cellClassName: "text-right" },
      { key: "min", label: "Minimo", cellClassName: "text-right" },
      { key: "max", label: "Massimo", cellClassName: "text-right" },
      { key: "supplier", label: "Fornitore", cellClassName: "text-left" }, // Esempio, puoi usare text-right se preferisci
    ];

    if (viewMode === "bom") {
      return allColumns.filter((col) =>
        ["diba_icon", "name", "description"].includes(col.key)
      );
    }

    return allColumns;
  }, [handleDibaIconClick, viewMode]);

  // Definisci i campi per il filtro dei ricambi
  const ricambiFilterFields = useMemo(
    () => [
      {
        name: "name",
        label: "Nome Articolo",
        type: "text",
        placeholder: "Cerca per nome...",
      },
      {
        name: "description",
        label: "Descrizione",
        type: "text",
        placeholder: "Cerca per descrizione...",
      },
      {
        name: "supplier",
        label: "Fornitore",
        type: "text",
        placeholder: "Cerca per fornitore...",
      },
      // Aggiungi altri campi se necessario, es. per quantità min/max se l'API lo supporta
    ],
    []
  );

  // Funzione per gestire la ricerca dei ricambi
  const handleSearchRicambi = async (filterValues) => {
    // Funzione unificata per ricerca e aggiornamento stato
    setLoading(true);
    setMessage("");
    try {
      const queryParams = {
        ...filterValues,
        page: 1,
        page_size: rowsPerPage,
        order_by: sortKey || "name",
        order_dir: sortOrder,
      };

      const resultsFromSearch = await ricambiApi.fetchByFilters(queryParams);

      if (resultsFromSearch && Array.isArray(resultsFromSearch.rows)) {
        setRicambi(resultsFromSearch.rows);
        setTotalCount(resultsFromSearch.meta?.totalRows || resultsFromSearch.rows.length);
        setPage(0); // resetta alla prima pagina
        if (resultsFromSearch.rows.length === 0) {
          setMessage("ℹ️ Nessun ricambio trovato con i filtri specificati.");
        }
      } else {
        throw new Error(
          resultsFromSearch?.error || "Dati filtrati non validi."
        );
      }
    } catch (err) {
      console.error("Errore nella ricerca ricambi:", err);
      setMessage(`❌ Errore ricerca ricambi: ${err.message || err}`);
      setRicambi([]);
    } finally {
      setLoading(false);
    }
  };

  // Gestore per la fine del trascinamento (react-beautiful-dnd)
  const onDragEnd = (result) => {
    const { source, destination, draggableId } = result;
    // L'utente ha lasciato l'elemento fuori da una zona di rilascio valida
    if (!destination) {
      return;
    }

    //L'elemento è stato trascinato dalla lista articoli alla distinta base
    if (
      source.droppableId === "articoli-disponibili" &&
      destination.droppableId === "diba-components"
    ) {
      const articleId = parseInt(draggableId, 10);
      const article = ricambi.find((r) => r.id === articleId);
      if (article) {
        // Usiamo uno stato per comunicare l'articolo al figlio
        setDroppedArticle(article);
      }
    }
    // Non facciamo nulla se l'elemento viene rilasciato nella stessa lista
    // (non implementiamo il riordino qui)
  };

  return (
    <>
      <Header
        onAdd={handleNew}
        onSearch={toggleSearchPanel} // Aggiungi handler per il pulsante di ricerca
        onEdit={() => {
          console.log(
            "[Header onEdit] Triggered. Current selectedIds:",
            selectedIds
          );
          if (selectedIds.length === 0) {
            alert("Seleziona un ricambio da modificare");
            console.log("[Header onEdit] No item selected.");
            return;
          }
          if (selectedIds.length > 1) {
            alert(
              "Puoi modificare solo un ricambio alla volta dall'header. Seleziona una singola riga."
            );
            console.log(
              "[Header onEdit] Multiple items selected for single edit:",
              selectedIds.length
            );
            return;
          }
          const itemToEdit = ricambi.find((r) => r.id === selectedIds[0]);
          if (itemToEdit) {
            console.log("[Header onEdit] Item to edit found:", itemToEdit);
            handleEdit(itemToEdit);
            setSelectedIds([]);
            console.log(
              "[Header onEdit] selectedIds cleared after finding item."
            );
          } else {
            alert(
              "Ricambio selezionato non trovato. Potrebbe essere stato eliminato o la selezione non è valida."
            );
            console.warn(
              "[Header onEdit] Item to edit not found for ID:",
              selectedIds[0]
            );
            setSelectedIds([]);
            console.log(
              "[Header onEdit] selectedIds cleared after item not found."
            );
          }
        }}
        onDelete={() => {
          console.log(
            "[Header onDelete] Triggered. Current selectedIds:",
            selectedIds
          );
          if (selectedIds.length === 0) {
            alert("Seleziona almeno una riga da eliminare.");
            console.log("[Header onDelete] No items selected for deletion.");
            return;
          }
          if (
            window.confirm(
              `Confermi l'eliminazione di ${selectedIds.length} element${
                selectedIds.length > 1 ? "i" : "o"
              } selezionat${selectedIds.length > 1 ? "i" : "o"}?`
            )
          ) {
            console.log(
              "[Header onDelete] Deletion confirmed for IDs:",
              selectedIds
            );
            selectedIds.forEach((id) => handleDelete(id));
            setSelectedIds([]);
            console.log(
              "[Header onDelete] selectedIds cleared after initiating deletions."
            );
          } else {
            console.log("[Header onDelete] Deletion cancelled by user.");
          }
        }}
        onManageBOM={handleManageBOM}
        currentUser={currentUser} // Passa currentUser a Header
        currentLocation={currentLocation}
        onLogout={onLogout} // Passa la funzione di logout a Header
      />

      <DragDropContext onDragEnd={onDragEnd}>
        <div className="container">
          {showSearch && (
            <FilterSearch
              fields={ricambiFilterFields}
              onSearch={handleSearchRicambi} // Passa la funzione unificata
            />
          )}

          {message && <div className="message-info">{message}</div>}
          <div className={viewMode === "bom" ? "bom-view-container" : ""}>
            <div className="table-wrapper">
              <div className="table-panel articoli-panel">
                <TableGrid
                  title="Gestione Articoli"
                  columns={tableColumns}
                  rows={currentTableData}
                  selectedIds={selectedIds}
                  onRowSelectionChange={(id, checked) => {
                    if (checked) {
                      setSelectedIds((prev) => [...prev, id]);
                    } else {
                      setSelectedIds((prev) =>
                        prev.filter((selId) => selId !== id)
                      );
                    }
                  }}
                  areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
                  onSelectAllCurrentPageRowsChange={
                    handleSelectAllCurrentPageRowsChange
                  }
                  sortKey={sortKey}
                  sortOrder={sortOrder}
                  onSort={toggleSort}
                  onEdit={handleEdit}
                  onDelete={handleDelete}
                  loading={loading}
                  onClearAllSelections={() => setSelectedIds([])}
                  areAnyRowsSelected={selectedIds.length > 0}
                  // Abilita il drag-and-drop solo quando la vista della distinta base è attiva
                  droppableId={
                    viewMode === "bom" ? "articoli-disponibili" : undefined
                  }
                />

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
              </div>
            </div>
            {/* Sezione Distinta Base */}
            {viewMode === "bom" && currentRicambioForBOM && (
              <div className="diba-table-wrapper">
                <DiBaTable
                  ricambioPadre={currentRicambioForBOM}
                  onClose={() => {
                    setViewMode("ricambi");
                    setCurrentRicambioForBOM(null);
                    setSelectedIds([]); // Deseleziona anche l'ID
                  }}
                  // Passiamo l'articolo trascinato e una funzione per resettarlo
                  droppedArticle={droppedArticle}
                  onDropProcessed={() => setDroppedArticle(null)}
                />
              </div>
            )}
          </div>
          {/* Renderizza il Popover della DiBa */}
          <DiBaPopover
            anchorEl={popoverAnchorEl}
            open={Boolean(popoverAnchorEl)}
            onClose={handlePopoverClose}
            data={popoverData}
            loading={popoverLoading}
          />

          <DialogCustom
            open={formVisible && viewMode === "ricambi"} // Mostra solo se non siamo in modalità BOM
            onClose={() => setFormVisible(false)}
            onSubmit={handleSubmit}
            title={isEditing ? "Modifica Articolo" : "Nuovo Articolo"}
            submitButtonText={
              isSubmitting
                ? "Salvataggio..."
                : isEditing
                ? "Aggiorna Articolo"
                : "Salva Articolo"
            }
            isSubmitting={isSubmitting}
          >
            <label htmlFor="ricambiForm-name">Nome:</label>
            <input
              id="ricambiForm-name"
              type="text"
              name="name"
              placeholder="Nome"
              value={formData.name}
              onChange={handleChange}
              autoComplete="off"
            />
            <label htmlFor="description">Descrizione:</label>
            <textarea
              id="ricambiForm-description"
              name="description"
              placeholder="Descrizione"
              rows={3}
              value={formData.description}
              onChange={handleChange}
              autoComplete="off"
            />
            <label htmlFor="ricambiForm-quantita">Quantità:</label>
            <input
              id="ricambiForm-quantita"
              type="number"
              name="quantita"
              placeholder="Quantità"
              value={formData.quantita}
              onChange={handleChange}
              autoComplete="off"
            />
            <label htmlFor="ricambiForm-min">Quantità min:</label>
            <input
              id="ricambiForm-min"
              type="number"
              name="min"
              placeholder="Minimo"
              value={formData.min}
              onChange={handleChange}
              autoComplete="off"
            />
            <label htmlFor="ricambiForm-max">Quantità max:</label>
            <input
              id="ricambiForm-max"
              type="number"
              name="max"
              placeholder="Massimo"
              value={formData.max}
              onChange={handleChange}
              autoComplete="off"
            />
            <label htmlFor="ricambiForm-supplier">Fornitore:</label>
            <input
              id="ricambiForm-supplier"
              type="text"
              name="supplier"
              placeholder="Fornitore"
              value={formData.supplier}
              onChange={handleChange}
              autoComplete="organization"
            />
          </DialogCustom>
        </div>
      </DragDropContext>
    </>
  );
}
