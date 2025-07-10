//=================================
//File: MovimentiTable.jsx
//Componente per la gestione dei movimenti 
//di magazzino.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-12"
//==================================
import React, { useEffect, useState, useMemo, useCallback } from "react";
import {}
import DialogCustom from "./DialogCustom";
import FilterSearch from"./FilterSearch";
import Pagination from "./Pagination1";
import TableGrid from "./TableGrid";
import movimentiApi from "../api/movimentiApi"; // API per le operazioni sui movimenti
import ricambiApi from "../api/ricambiApi"; // API per gli articoli/ricambi
import causaliApi from "../api/causaliApi"; // API per le causali
import userApi from "../api/userApi"; // API per gli utenti
import "../css/ArticoliTable.css"; // importa il file css per coerenza
import Header from "./Header"; // Aggiunto import per Header

const rowsPerPageOptions = [5, 10, 20, 50];

const initialDialogFormData = {
  id: null, // ID del movimento per la modifica
  idart: "",
  codice_cau: "",
  data: new Date().toISOString().slice(0, 10), // Data odierna di default YYYY-MM-DD
  quantita: "",
  tipo: "", // 'carico' o 'scarico'
  note: "",
};

// Definizione colonne per la tabella
const tableColumns = [
  { key: "id", label: "ID Mov.", cellClassName: "text-center" },
  { key: "data", label: "Data", cellClassName: "text-center" }, // Verrà mostrato come YYYY-MM-DD
  { key: "idart", label: "ID Art.", cellClassName: "text-center" },
  { key: "descriptionart", label: "Nome Articolo", cellClassName: "text-left" },
  { key: "quantita", label: "Q.tà", cellClassName: "text-right" },
  { key: "um", label: "UM", cellClassName: "text-left"},
  {
    key: "tipo",
    label: "Tipo",
    cellClassName: (row) => {
      let classes = "text-center";
      if (row.tipo === "C") {
        classes += " tipo-carico";
      } else if (row.tipo === "S") {
        classes += " tipo-scarico";
      }
      return classes;
    },
  },
  { key: "descriptioncau", label: "Causale", cellClassName: "text-left" },
  { key: "user", label: "Utente", cellClassName: "text-left"},
  { key: "timestamp", label: "Timestamp", cellClassName: "text-left"},
  { key: "note", label: "Note", cellClassName: "text-left" },
];

export default function MovimentiTable({currentUser, currentLocation,onLogout}) {
  
  const [articoliList, setArticoliList] = useState([]);
  const [causaliList, setCausaliList] = useState([]);
  const [dialogFormData, setDialogFormData] = useState(initialDialogFormData);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [loadingArticoli, setLoadingArticoli] = useState(false);
  const [loadingCausali, setLoadingCausali] = useState(false);
  const [loadingTable, setLoadingTable] = useState(false);
  const [loadingUsers, setLoadingUsers] = useState(false);
  const [message, setMessage] = useState(""); // Stato per i messaggi all'utente
  const [movimenti, setMovimenti] = useState([]);
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [selectedIds, setSelectedIds] = useState([]);
  const [showSearch, setShowSearch] = useState(false);
  const [sortKey, setSortKey] = useState("data");
  const [sortOrder, setSortOrder] = useState("desc");
  const [usersList, setUsersList] = useState([]);
  const toggleSearchPanel = () => {
    setShowSearch((prev) => !prev);
  };

  // Define filter fields for Movimenti
  const movimentiFilterFields = useMemo(() => [
    
    { name: "idart", label: "Articolo", type: "select", options: articoliList.map(art => ({ value: art.id, label: `${art.name} (ID: ${art.id})` })), placeholder: "-- Seleziona Articolo --" },
    { name: "codice_cau", label: "Causale", type: "select", options: causaliList.map(cau => ({ value: cau.id, label: `${cau.codice} - ${cau.description} (ID: ${cau.id})` })), placeholder: "-- Seleziona Causale --" },
    { name: "tipo", label: "Tipo", type: "select", options: [{ value: "C", label: "Carico" }, { value: "S", label: "Scarico" }], placeholder: "-- Seleziona Tipo --" },
    { name: "dataDa", label: "Data Da", type: "date" },
    { name: "dataA", label: "Data A", type: "date" },
    { name: "user", label: "Utente", type: "select", options: usersList.map(u => ({ value: u.username , label: u.username })), placeholder: "--Seleziona Utente--"}
  ], [articoliList, causaliList, usersList]); // Dipendenze per rigenerare se liste cambiano
   
    // Function to handle the search triggered by FilterSearch
  // This function receives the filter values collected by FilterSearch
  const handleSearchMovimenti = async (filterValues) => {
    // log per veder i valori di filtro
    //console.log("[DEBUG] Filtro prima chiamata API:", filterValus);
    setLoadingTable(true);
    setMessage("");
    try {
      const query = {};
      if (filterValues.idart) query.idart = filterValues.idart; // Assuming idart is the ID
      if (filterValues.codice_cau) query.codice_cau = filterValues.codice_cau; // Assuming codice_cau is the ID
      if (filterValues.tipo) query.tipo = filterValues.tipo;
      if (filterValues.dataDa) query.dataDa = filterValues.dataDa;
      if (filterValues.dataA) query.dataA = filterValues.dataA;
      if (filterValues.user) query.user = filterValues.user;

      //console.log("FilterValues ricevuti:", filterValues);
      //console.log("Query costruita per API:", query);
      const res = await movimentiApi.fetchByFilters(query); // This might return [dataArray, metadataObject] or just dataArray
      
      //console.log("Risposta raw dall'API:", res); // Logga la risposta prima del .map

      let dataToProcess = res;
      // Check if the response is an array where the first element is the actual data array
      if (Array.isArray(res) && Array.isArray(res[0]) && res.length === 2 && typeof res[1] === 'object') {
        dataToProcess = res[0];
      }

      if (Array.isArray(dataToProcess)) {
        const formattedData = dataToProcess.map((m) => ({
          ...m,
          data: m.data
            ? new Date(m.data).toISOString().slice(0, 10)
            : "",
        }));
        

        setMovimenti(formattedData);
        if (formattedData.length === 0) {
          setMessage("ℹ️ Nessun movimento trovato con i filtri specificati.");
        }
      } else {
        throw new Error("Dati filtrati non validi.");
      }
    } catch (err) {
      console.error("Errore nei filtri:", err);
      setMessage(`❌ Errore nella ricerca: ${err.message || err}`);
      setMovimenti([]);
    } finally {
      setLoadingTable(false);
    }
  };

  const fetchMovimenti = useCallback(async () => {
    
    setLoadingTable(true);
    setMessage("");
    try {
      const res = await movimentiApi.fetchAll(); // This might return [dataArray, metadataObject] or just dataArray
      //console.log('MO - Risposta API fetchMovimenti;', res.data);
      
      let dataToProcess = res;
      if (Array.isArray(res) && Array.isArray(res[0]) && res.length === 2 && typeof res[1] === 'object') {
        dataToProcess = res[0];
      }

      if (Array.isArray(dataToProcess)) {
        setMovimenti(
          dataToProcess.map((m) => ({
            ...m,
            // Assicurati che la data sia in formato YYYY-MM-DD per l'input e la visualizzazione semplice
            data: m.data
              ? new Date(m.data).toISOString().slice(0, 10)
              : "",
          }))
        );
        //console.log('MO - Movimenti dopo mapping fetchMovimenti', dataToProcess);
      } else {
        console.warn("Risposta non valida per i movimenti:", res);
        throw new Error("Dati movimenti non validi.");
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
      const res = await ricambiApi.fetchAll(); // Assuming this returns Array<Ricambio> directly
      if (Array.isArray(res)) {
        setArticoliList(res);
      } else {
        console.warn("Risposta non valida per gli articoli:", res);
        throw new Error("Dati articoli non validi.");
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
      const res = await causaliApi.fetchAll(); // Assuming this returns Array<Causale> directly
      if (Array.isArray(res)) {
        setCausaliList(res);
      } else {
        console.warn("Risposta non valida per le causali:", res);
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

  const fetchUsers = useCallback(async () => {
    setLoadingUsers(true);
    try {
      const res = await userApi.fetchAll();
      if (Array.isArray(res)) {
        setUsersList(res);
      } else {
        console.warn("Risposta non valida per gli utenti:", res);
      }
    } catch (err) {
      console.error("Errore nel caricamento utenti:", err);
      setMessage(
        (prev) =>
          prev + `\n⚠️ Errore caricamento utenti: ${err.message || err}`
      );
      setUsersList([]);
    } finally {
      setLoadingUsers(false);
    }
  }, []);

  useEffect(() => {
    fetchMovimenti();
    fetchArticoli();
    fetchCausali();
    fetchUsers();
  }, [fetchMovimenti, fetchArticoli, fetchCausali, fetchUsers]); // Aggiunte dipendenze corrette

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
      codice_cau: item.codice_cau || "",
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
        const res = await movimentiApi.delete(id); // Assuming this returns { success: boolean, error?: string }
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
      !dialogFormData.codice_cau ||
      !dialogFormData.data ||
      !dialogFormData.quantita ||
      !dialogFormData.um 
      ||
      !dialogFormData.tipo
    ) {
      //console.log(dialogFormData);
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

      if (isEditing) {
        // L'API attuale permette solo di aggiornare le note.
        res = await movimentiApi.update(dialogFormData.id, {
          note: dialogFormData.note,
        }); // Assuming this returns { success: boolean, error?: string }
      } else {
        const dataToSubmit = {
          ...dialogFormData,
          quantita: Number(dialogFormData.quantita), // Assicura che sia un numero
          user: currentUser?.username, // Aggiungi l'utente loggato
        };
        res = await movimentiApi.insert(dataToSubmit); // Assuming this returns { success: boolean, error?: string }
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
  }, [isEditing, dialogFormData, fetchMovimenti, currentUser]);

  const handleDialogChange = useCallback((e) => {
    const { name, value } = e.target;
    // log per verificare il valore nuovo quando cambio un campo tipo codice_cau, tipo etc.
    //console.log(`[DEBUG] Cambio campo ${name}:` , value );

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

    //console.log("articoliList:", articoliList);
    //console.log("causaliList:", causaliList);

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
        currentLocation={currentLocation}
        onLogout={onLogout}
      />
      <div className="container">
        <h1>Gestione Movimenti</h1>

      { showSearch && 
        (
        <FilterSearch
          fields={movimentiFilterFields} // Pass the defined fields
          onSearch={handleSearchMovimenti} // Pass the search handler function directly
        ></FilterSearch>
        )}

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
      onSubmit={handleDialogSubmit}
      title={isEditing ? "Modifica Movimento" : "Nuovo Movimento"}
      submitButtonText={
        isSubmitting
          ? "Salvataggio..."
          : isEditing
          ? "Aggiorna Movimento"
          : "Salva Movimento"
      }
      isSubmitting={isSubmitting}
    >
      {/* Campi del form */}

      <label htmlFor="MovimentiTable-idart">Articolo:</label>
      <select
        id="MovimentiTable-idart"
        name="idart"
        value={dialogFormData.idart || ""}
        onChange={handleDialogChange}
        required
        disabled={loadingArticoli || isSubmitting || (isEditing && !dialogFormData.idart)}
        autoComplete="off"
      >
        <option key="select-articolo-default" value="">
          -- Seleziona Articolo --
        </option>
        {loadingArticoli ? (
          <option key="loading-articoli" disabled>
            Caricamento articoli...
          </option>
        ) : (
          articoliList.map((art) => (
            <option key={`art-${art.id ?? Math.random()}`} value={art.id}>
              {art.name} (ID: {art.id})
            </option>
          ))
        )}
      </select>

      <label htmlFor="MovimentiTable-codice_cau">Causale:</label>
      <select
        id="MovimentiTable-codice_cau"
        name="codice_cau"
        value={dialogFormData.codice_cau || ""}
        onChange={handleDialogChange}
        required
        disabled={loadingCausali || isSubmitting || (isEditing && !dialogFormData.codice_cau)}
        autoComplete="off"
      >
        <option key="select-causale-default" value="">
          -- Seleziona Causale --
        </option>
        {loadingCausali ? (
          <option key="loading-causali" disabled>
            Caricamento causali...
          </option>
        ) : (
          causaliList.map((cau) => (
            <option key={`cau-${cau.id ?? Math.random()}`} value={cau.id}>
              {/*{cau.codice} - {cau.description} (ID: {cau.id})*/}
              {cau.codice}
            </option>
          ))
        )}
      </select>

      <label htmlFor="MovimentiTable-data">Data Movimento:</label>
      <input
        id="MovimentiTable-data"
        type="date"
        name="data"
        value={dialogFormData.data || ""}
        onChange={handleDialogChange}
        required
        disabled={isSubmitting}
        autoComplete="off"
      />

      <label htmlFor="MovimentiTable-quantita">Quantità:</label>
      <input
        id="MovimentiTable-quantita"
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

      <label htmlFor="MovimentiTable-tipo">Tipo Movimento:</label>
      <select
        id="MovimentiTable-tipo"
        name="tipo"
        value={dialogFormData.tipo || ""}
        onChange={handleDialogChange}
        required
        disabled={isSubmitting || (isEditing && dialogFormData.tipo)}
        autoComplete="off"
      >
        <option key="select-tipo-default" value="">
          -- Seleziona Tipo --
        </option>
        <option key="tipo-C" value="C">
          C
        </option>
        <option key="tipo-S" value="S">
          S
        </option>
      </select>

      <label htmlFor="MovimentiTable-note">Note:</label>
      <textarea
        id="MovimentiTable-note"
        name="note"
        placeholder="Note aggiuntive"
        rows={3}
        value={dialogFormData.note || ""}
        onChange={handleDialogChange}
        disabled={isSubmitting}
        autoComplete="off"
      />
    </DialogCustom>

      </div>
      
    </>
  );
}