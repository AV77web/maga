//=================================
//File: MovimentiForm.jsx
//Componente per la gestione dei movimenti 
//di magazzino.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================
import React, { useEffect, useState, useMemo, useCallback } from "react";
import DialogCustom from "./DialogCustom";
import FilterSearch from"./FilterSearch";
import Pagination from "./Pagination1";
import TableGrid from "./TableGrid";
import MovimentiDialogCustom from "./MovimentiDialogCustom";
import movimentiApi from "../api/movimentiApi"; // API per le operazioni sui movimenti
import ricambiApi from "../api/ricambiApi"; // API per gli articoli/ricambi
import causaliApi from "../api/causaliApi"; // API per le causali
import Header from "./Header"; // Aggiunto import per Header

const rowsPerPageOptions = [5, 10, 20, 50];

const initialDialogFormData = {
  id: null, // ID del movimento per la modifica
  idart: "",
  idcau: "",
  data: new Date().toISOString().slice(0, 10), // Data odierna di default YYYY-MM-DD
  quantita: "",
  tipo: "", // 'carico' o 'scarico'
  note: "",
};

// Definizione colonne per la tabella
const tableColumns = [
  { key: "id", label: "ID Mov.", cellClassName: "text-center" },
  { key: "data", label: "Data", cellClassName: "text-center" }, // Verrà mostrato come YYYY-MM-DD
  { key: "descriptionart", label: "Articolo", cellClassName: "text-left" },
  { key: "descriptioncau", label: "Causale", cellClassName: "text-left" },
  { key: "quantita", label: "Q.tà", cellClassName: "text-right" },
  { key: "tipo", label: "Tipo", cellClassName: "text-center" },
  { key: "note", label: "Note", cellClassName: "text-left" },
];

export default function MovimentiForm({currentUser}) {
  const [movimenti, setMovimenti] = useState([]);
  const [articoliList, setArticoliList] = useState([]);
  const [causaliList, setCausaliList] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [dialogFormData, setDialogFormData] = useState(initialDialogFormData);
  const [showSearch, setShowSearch] = useState(false);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [selectedIds, setSelectedIds] = useState([]);
  const [sortKey, setSortKey] = useState("data");
  const [sortOrder, setSortOrder] = useState("desc");
  const [loadingTable, setLoadingTable] = useState(false);
  const [message, setMessage] = useState(""); // Stato per i messaggi all'utente
  
  const [loadingArticoli, setLoadingArticoli] = useState(false);
  const [loadingCausali, setLoadingCausali] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const toggleSearchPanel = () => {
    setShowSearch((prev) => !prev);
  };

  // Define filter fields for Movimenti
  const movimentiFilterFields = useMemo(() => [
    { name: "idart", label: "Articolo", type: "select", options: articoliList.map(art => ({ value: art.id, label: `${art.name} (ID: ${art.id})` })), placeholder: "-- Seleziona Articolo --" },
    { name: "idcau", label: "Causale", type: "select", options: causaliList.map(cau => ({ value: cau.id, label: `${cau.codice} - ${cau.description} (ID: ${cau.id})` })), placeholder: "-- Seleziona Causale --" },
    { name: "tipo", label: "Tipo", type: "select", options: [{ value: "C", label: "Carico" }, { value: "S", label: "Scarico" }], placeholder: "-- Seleziona Tipo --" },
    { name: "dataDa", label: "Data Da", type: "date" },
    { name: "dataA", label: "Data A", type: "date" },
  ], [articoliList, causaliList]); // Dipendenze per rigenerare se liste cambiano

  // Function to handle the search triggered by FilterSearch
  // This function receives the filter values collected by FilterSearch
  const handleSearchMovimenti = async (filterValues) => {
    try {
      const query = {};
      if (filterValues.idart) query.idart = filterValues.idart;
      if (filterValues.idcau) query.idcau = filterValues.idcau;
      if (filterValues.tipo) query.tipo = filterValues.tipo;
      if (filterValues.dataDa) query.dataDa = filterValues.dataDa; // Assumi che l'API gestisca il formato data
      if (filterValues.dataA) query.dataA = filterValues.dataA;   // Assumi che l'API gestisca il formato data

      console.log("FilterValues ricevuti:", filterValues);
      console.log("Query costruita per API:", query);
      const res = await movimentiApi.fetchByFilters(query);
      console.log("Risposta raw dall'API:", res); // Logga la risposta prima del .map



      if (res.success && Array.isArray(res.data)) {
        // Return the raw data array. The onResults handler will format it.
        // Ensure descriptionart is included in the data returned by the API
        // (This requires backend modification or joining in the API query if not already done)
        return res.data.map((m) => ({
          ...m,
          data: m.data
            ? new Date(m.data).toISOString().slice(0, 10)
            : "",
        }))
      
    } else {
      throw new Error(res.error || "Dati filtrati non validi.");
    }
  } catch (err) {
    console.error("Errore nei filtri:", err);
    // Throw the error so FilterSearch can catch and display it
    throw new Error(`Errore nella ricerca: ${err.message || err}`);
  }
  // Note: setLoadingTable and setMessage are handled by handleFilterResults now
};

  // Function to handle the results received from FilterSearch
  const handleFilterResults = (resultsFromSearch) => {
    setLoadingTable(true); // Potrebbe essere già true da FilterSearch, ma meglio assicurarsi
    setMessage(""); // Pulisce i messaggi precedenti
    try {
      if (Array.isArray(resultsFromSearch)) {
        setMovimenti(resultsFromSearch); // I dati sono già formattati in handleSearchMovimenti
        if (resultsFromSearch.length === 0) {
          setMessage("ℹ️ Nessun movimento trovato con i filtri specificati.");
        }
      } else {
        throw new Error("I risultati della ricerca non sono validi.");
      }
    } catch (err) {
      console.error("Errore nell'elaborazione dei risultati del filtro:", err);
      setMessage(`❌ Errore nell'elaborazione dei risultati: ${err.message || err}`);
      setMovimenti([]); // Pulisce la tabella in caso di errore
  } finally {
    setLoadingTable(false);
  }
};

  const fetchMovimenti = useCallback(async () => {
    setLoadingTable(true);
    setMessage("");
    try {
      const res = await movimentiApi.fetchAll();
      if (res.success && Array.isArray(res.data)) {
        setMovimenti(
          res.data.map((m) => ({
            ...m,
            // Assicurati che la data sia in formato YYYY-MM-DD per l'input e la visualizzazione semplice
            data: m.data
              ? new Date(m.data).toISOString().slice(0, 10)
              : "",
          }))
        );
      } else {
        console.warn("Risposta non valida per i movimenti:", res);
        throw new Error(res.error || "Dati movimenti non validi.");
      }
    } catch (err) {
      console.error("Errore nel recupero movimenti:", err);
      setMessage(`❌ Errore caricamento movimenti: ${err.message || err}`);
      setMovimenti([]);
    } finally {
      setLoadingTable(false);
    }
  }, []);

  const fetchArticoli = useCallback(async () => {
    setLoadingArticoli(true);
    try {
      const res = await ricambiApi.fetchAll();
      if (res.success && Array.isArray(res.data)) {
        setArticoliList(res.data);
      } else {
        console.warn("Risposta non valida per gli articoli:", res);
        throw new Error(res.error || "Dati articoli non validi.");
      }
    } catch (err) {
      console.error("Errore nel caricamento articoli:", err);
      setMessage(
        (prev) =>
          prev + `\n❌ Errore caricamento articoli: ${err.message || err}`
      );
      setArticoliList([]);
    } finally {
      setLoadingArticoli(false);
    }
  }, []);

  const fetchCausali = useCallback(async () => {
    setLoadingCausali(true);
    try {
      const res = await causaliApi.fetchAll();
      if (Array.isArray(res.data)) {
        setCausaliList(res.data);
      } else {
        console.warn("Risposta non valida per le causali:", res.data);
        throw new Error("Dati causali non validi.");
      }
    } catch (err) {
      console.error("Errore nel caricamento causali:", err);
      setMessage(
        (prev) =>
          prev + `\n❌ Errore caricamento causali: ${err.message || err}`
      );
      setCausaliList([]);
    } finally {
      setLoadingCausali(false);
    }
  }, []);

  useEffect(() => {
    fetchMovimenti();
    fetchArticoli();
    fetchCausali();
  }, [fetchMovimenti, fetchArticoli, fetchCausali]); // Aggiunte dipendenze corrette

  const sortedMovimenti = useMemo(() => {
    return [...movimenti].sort((a, b) => {
      const valA = a[sortKey];
      const valB = b[sortKey];

      if (valA === null || valA === undefined) return 1;
      if (valB === null || valB === undefined) return -1;

      if (sortKey === "data") {
        // Le date sono stringhe YYYY-MM-DD, confrontabili come stringhe
        return sortOrder === "asc"
          ? valA.localeCompare(valB)
          : valB.localeCompare(valA);
      }
      if (typeof valA === "number" && typeof valB === "number") {
        return sortOrder === "asc" ? valA - valB : valB - valA;
      }
      if (typeof valA === "string" && typeof valB === "string") {
        return sortOrder === "asc"
          ? valA.localeCompare(valB)
          : valB.localeCompare(valA);
      }
      return 0;
    });
  }, [movimenti, sortKey, sortOrder]);

  const currentTableData = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return sortedMovimenti.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, sortedMovimenti]);

  const toggleSort = (key) => {
    if (key === sortKey) {
      setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
    } else {
      setSortKey(key);
      setSortOrder("asc");
    }
    setPage(0);
  };

  const handleNew = useCallback(() => {
    setDialogFormData(initialDialogFormData);
    setIsEditing(false);
    setFormVisible(true);
  }, []);

  const handleEdit = useCallback((item) => {
    setDialogFormData({
      id: item.id,
      idart: item.idart || "",
      idcau: item.idcau || "",
      // data è già YYYY-MM-DD dallo stato movimenti
      data:
        item.data || new Date().toISOString().slice(0, 10),
      quantita: item.quantita || "",
      tipo: item.tipo || "",
      note: item.note || "",
    });
    setIsEditing(true);
    setFormVisible(true);
  }, []);

  const handleDelete = useCallback(
    async (id) => {
      if (
        !window.confirm(
          `Confermi l'eliminazione del movimento ID ${id}? L'operazione aggiornerà la giacenza dell'articolo.`
        )
      )
        return;
      setLoadingTable(true);
      setMessage("Eliminazione in corso...");
      try {
        const res = await movimentiApi.delete(id);
        if (!res.success)
          throw new Error(res.error || "Errore server durante l'eliminazione.");
        setMessage("✅ Movimento eliminato con successo!");
        fetchMovimenti();
        setSelectedIds((prev) => prev.filter((sid) => sid !== id));
      } catch (err) {
        console.error("Errore eliminazione:", err);
        setMessage(`❌ Errore eliminazione: ${err.message || err}`);
      } finally {
        setLoadingTable(false);
      }
    },
    [fetchMovimenti]
  );

  const handleDialogSubmit = useCallback(async () => {
    if (
      !dialogFormData.idart ||
      !dialogFormData.idcau ||
      !dialogFormData.data ||
      !dialogFormData.quantita ||
      !dialogFormData.tipo
    ) {
      setMessage("❌ Compila tutti i campi obbligatori del movimento.");
      return;
    }
    if (
      isNaN(Number(dialogFormData.quantita)) ||
      Number(dialogFormData.quantita) <= 0
    ) {
      setMessage("❌ La quantità movimentata deve essere un numero positivo.");
      return;
    }

    setIsSubmitting(true);
    setMessage("Salvataggio in corso...");
    try {
      let res;
      const dataToSubmit = {
        ...dialogFormData,
        quantita: Number(dialogFormData.quantita), // Assicura che sia un numero
      };

      if (isEditing) {
        // L'API attuale permette solo di aggiornare le note.
        res = await movimentiApi.update(dataToSubmit.id, {
          note: dataToSubmit.note,
        });
      } else {
        res = await movimentiApi.insert(dataToSubmit);
      }
      if (!res.success)
        throw new Error(res.error || "Errore server durante il salvataggio.");
      setMessage(
        isEditing
          ? "✅ Nota movimento aggiornata!"
          : "✅ Movimento registrato con successo!"
      );
      fetchMovimenti();
      setFormVisible(false);
    } catch (err) {
      console.error("Errore salvataggio:", err);
      setMessage(`❌ Errore salvataggio: ${err.message || err}`);
    } finally {
      setIsSubmitting(false);
    }
  }, [isEditing, dialogFormData, fetchMovimenti]);

  const handleDialogChange = useCallback((e) => {
    const { name, value } = e.target;
    setDialogFormData((prev) => ({ ...prev, [name]: value }));
  }, []);

  const handleSelectAllCurrentPageRowsChange = useCallback(
    (checked) => {
      if (checked) {
        const newIds = currentTableData.map((row) => row.id);
        setSelectedIds((prev) => [...new Set([...prev, ...newIds])]);
      } else {
        const currentIdsOnPage = currentTableData.map((row) => row.id);
        setSelectedIds((prev) =>
          prev.filter((id) => !currentIdsOnPage.includes(id))
        );
      }
    },
    [currentTableData]
  );

  const handleRowSelectionChange = useCallback((rowId, checked) => {
    setSelectedIds((prev) =>
      checked ? [...prev, rowId] : prev.filter((id) => id !== rowId)
    );
  }, []);

  const areAllCurrentPageRowsSelected = useMemo(() => {
    return (
      currentTableData.length > 0 &&
      currentTableData.every((row) => selectedIds.includes(row.id))
    );
  }, [currentTableData, selectedIds]);
  console.log("causaliList attuale:", causaliList);

  return (
    <>
      <Header
        onSearch={toggleSearchPanel}
        onAdd={handleNew}
        onEdit={() => {
          if (selectedIds.length !== 1) {
            alert("Seleziona un singolo movimento da modificare.");
            return;
          }
          const itemToEdit = movimenti.find((m) => m.id === selectedIds[0]);
          if (itemToEdit) {
            handleEdit(itemToEdit);
          } else {
            alert("Elemento non trovato.");
          }
          // setSelectedIds([]); // Potresti volerlo deselezionare dopo aver aperto il modale
        }}
        onDelete={() => {
          if (selectedIds.length === 0) {
            alert("Seleziona almeno un movimento da eliminare.");
            return;
          }
          if (
            window.confirm(
              `Confermi l'eliminazione di ${selectedIds.length} movimenti selezionati? L'operazione aggiornerà le giacenze.`
            )
          ) {
            // Idealmente, un endpoint batch per l'eliminazione multipla
            Promise.all(selectedIds.map((id) => movimentiApi.delete(id)))
              .then((results) => {
                const allSuccess = results.every((res) => res.success);
                if (allSuccess) {
                  setMessage(
                    `✅ ${selectedIds.length} movimenti eliminati con successo!`
                  );
                } else {
                  setMessage(
                    `⚠️ Alcuni movimenti potrebbero non essere stati eliminati. Controllare i log.`
                  );
                  results.forEach((res) => {
                    if (!res.success)
                      console.error("Errore eliminazione batch:", res.error);
                  });
                }
                fetchMovimenti();
                setSelectedIds([]);
              })
              .catch((err) => {
                console.error("Errore grave eliminazione batch:", err);
                setMessage(
                  `❌ Errore grave durante l'eliminazione multipla: ${err.message}`
                );
                fetchMovimenti(); // Ricarica comunque per vedere lo stato attuale
              });
          }
        }}
        currentUser={currentUser}
      />
      { showSearch && 
        (
        <FilterSearch
          fields={movimentiFilterFields} // Pass the defined fields
          onSearch={handleSearchMovimenti} // Pass the search handler function
          onResults={handleFilterResults} // Pass the results handler
        ></FilterSearch>
        )}

      <div className="container">
        <h1>Gestione Movimenti</h1>

        {message && (
          <div
            className={`message-info ${
              message.includes("✅")
                ? "message-success"
                : message.includes("❌")
                ? "message-error"
                : message.includes("⚠️")
                ? "message-warning"
                : ""
            }`}
          >
            {message.split("\n").map((str, index) => (
              <p key={index}>{str}</p>
            ))}
          </div>
        )}

        <div className="table-wrapper">
          <TableGrid
            columns={tableColumns}
            rows={currentTableData}
            selectedIds={selectedIds}
            onRowSelectionChange={handleRowSelectionChange}
            areAllCurrentPageRowsSelected={areAllCurrentPageRowsSelected}
            onSelectAllCurrentPageRowsChange={
              handleSelectAllCurrentPageRowsChange
            }
            sortKey={sortKey}
            sortOrder={sortOrder}
            onSort={toggleSort}
            onEdit={handleEdit} // Passa la funzione per modificare la singola riga
            onDelete={handleDelete} // Passa la funzione per eliminare la singola riga
            loading={loadingTable}
            onClearAllSelections={() => setSelectedIds([])} // Funzione per deselezionare tutto
            areAnyRowsSelected={selectedIds.length > 0} // Per abilitare/disabilitare azioni di massa
          />
        </div>

        <div className="pagination-bar">
          <Pagination
            currentPage={page + 1}
            totalCount={sortedMovimenti.length}
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
              disabled={loadingTable}
            >
              {rowsPerPageOptions.map((opt) => (
                <option key={opt} value={opt}>
                  {opt}
                </option>
              ))}
            </select>
          </label>
        </div>
    <DialogCustom
      open={formVisible}
      onClose={() => setFormVisible(false)}
      onSubmit={handleDialogSubmit} // La logica di submit rimane nel componente padre
      title={isEditing ? "Modifica Movimento" : "Nuovo Movimento"}
      submitButtonText={isSubmitting ? "Salvataggio..." : isEditing ? "Aggiorna Movimento" : "Salva Movimento"}
      isSubmitting={isSubmitting} // Passa lo stato di sottomissione
    >
      {/* Questi sono i children: i campi specifici del form Movimento */}
      <label htmlFor="movimentiForm-idart">Articolo:</label>
      <select
        id="movimentiForm-idart"
        name="idart"
        value={dialogFormData.idart || ""}
        onChange={handleDialogChange} // L'handler onChange rimane nel componente padre
        required
        disabled={loadingArticoli || isSubmitting || (isEditing && !dialogFormData.idart)}
        autoComplete="off"
      >
        <option value="">-- Seleziona Articolo --</option>
        {loadingArticoli ? (
          <option disabled>Caricamento articoli...</option>
        ) : (
          articoliList.map((art) => (
            <option key={art.id} value={art.id}>
              {art.name} (ID: {art.id})
            </option>
          ))
        )}
      </select>

      <label htmlFor="movimentiForm-idcau">Causale:</label>
      <select
        id="movimentiForm-idcau"
        name="idcau"
        value={dialogFormData.idcau || ""}
        onChange={handleDialogChange}
        required
        disabled={loadingCausali || isSubmitting || (isEditing && !dialogFormData.idcau)}
        autoComplete="off"
      >
        <option value="">-- Seleziona Causale --</option>
        {loadingCausali ? (
          <option disabled>Caricamento causali...</option>
        ) : (
          causaliList.map((cau) => (
            <option key={cau.id} value={cau.id}>
              {cau.codice} - {cau.description} (ID: {cau.id})
            </option>
          ))
        )}
      </select>

      <label htmlFor="movimentiForm-data">Data Movimento:</label>
      <input
        id="movimentiForm-data"
        type="date"
        name="data"
        value={dialogFormData.data || ""}
        onChange={handleDialogChange}
        required
        disabled={isSubmitting}
        autoComplete="off"
      />

      <label htmlFor="movimentiForm-quantita">Quantità:</label>
      <input
        id="movimentiForm-quantita"
        type="number"
        name="quantita"
        placeholder="Quantità"
        value={dialogFormData.quantita || ""}
        onChange={handleDialogChange}
        required
        min="1"
        disabled={isSubmitting || (isEditing && typeof dialogFormData.quantita !== "undefined")}
        autoComplete="off"
      />

      <label htmlFor="movimentiForm-tipo">Tipo Movimento:</label>
      <select
        id="movimentiForm-tipo"
        name="tipo"
        value={dialogFormData.tipo || ""}
        onChange={handleDialogChange}
        required
        disabled={isSubmitting || (isEditing && dialogFormData.tipo)}
        autoComplete="off"
      >
        <option value="">-- Seleziona Tipo --</option>
        <option value="C">C</option>
        <option value="S">S</option>
      </select>

      <label htmlFor="movimentiForm-note">Note:</label>
      <textarea
        id="movimentiForm-note"
        name="note"
        placeholder="Note aggiuntive"
        rows={3}
        value={dialogFormData.note || ""}
        onChange={handleDialogChange}
        disabled={isSubmitting}
        autoComplete="off"
      />
    </DialogCustom>     
        {/*<MovimentiDialogCustom
          open={formVisible}
          onClose={() => setFormVisible(false)}
          onSubmit={handleDialogSubmit}
          isEditing={isEditing}
          formData={dialogFormData}
          onChange={handleDialogChange}
          articoliList={articoliList}
          causaliList={causaliList}
          loadingArticoli={loadingArticoli}
          loadingCausali={loadingCausali}
          isSubmitting={isSubmitting}
        />*/}
      </div>
      
    </>
  );
}
