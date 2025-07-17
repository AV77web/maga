//============================================================
//File: Ordini.jsx
//Componente che gestisce la visualizzazione e la modifica
//degli ordini, combinando una vista master (lista ordini)
//con una vista detail (testata e righe ordine).
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-07"
//============================================================

import React, { useState, useEffect, useMemo, useCallback } from 'react';
import ordiniApi from '../api/ordiniApi';
import ordiniRigheApi from '../api/ordiniRigheApi'; // API per le righe
import counterpartiesApi from '../api/counterpartiesApi'; // API per i fornitori
import FilterSearch from './FilterSearch';
import Header from './Header';
import TableGrid from './TableGrid';
import DocumentHeaderForm from './DocumentHeaderForm';
import orderSchema from '#schemas/order.schema.json';
import { orderUiHints } from '../uiHints/orderUiHints';
import Pagination from './Pagination1';
import OrdineRigaDialog from './OrdineRigaDialog'; // Importa il nuovo dialog
import '../css/Ordini.css'; // Riusiamo lo stile per coerenza
import '../css/ArticoliTable.css'; // Uniforme con altri componenti

const rowsPerPageOptions = [5, 10, 20, 50];

const Ordini = ({
  currentUser,
  currentLocation,
  onLogout,
  onRowNavigate = () => {},
  onCreateNavigate = () => {},
  ...props
}) => {
  // --- STATI ---
  const [ordiniList, setOrdiniList] = useState([]); // Lista di tutti gli ordini (master)
  const [selectedOrdine, setSelectedOrdine] = useState(null); // Dati della testata dell'ordine selezionato
  const [ordineRighe, setOrdineRighe] = useState([]); // Righe dell'ordine selezionato
  const [selectedMasterIds, setSelectedMasterIds] = useState([]); // ID selezionati nella tabella master
  const [selectedDetailIds, setSelectedDetailIds] = useState([]); // ID selezionati nella tabella detail
  const [sortKey, setSortKey] = useState("num_ordine");
  const [sortOrder, setSortOrder] = useState("asc");
  const [showSearch, setShowSearch] = useState(false); // Stato per il panello di ricerca
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [totalCount, setTotalCount] = useState(0);
  const [totalPages, setTotalPages] = useState(1);
  const [isEditing, setIsEditing] = useState(false); // <--- Stato per attivare HeadDocument in modifica

  // Stati per il dialog delle righe
  const [isRigaDialogOpen, setIsRigaDialogOpen] = useState(false);
  const [editingRiga, setEditingRiga] = useState(null); // Riga in modifica/creazione


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

  // --- CONFIGURAZIONI ---
  // Colonne per la tabella master degli ordini
  const masterColumns = useMemo(() => [
    { key: 'id', label: 'ID Ordine', cellClassName: 'text-center' },
    { key: 'num_ordine', label: 'Numero Ordine', cellClassName: 'text-left' },
    { key: 'data_ordine', label: 'Data', cellClassName: 'text-center' },
    { key: 'fornitore_id', label: 'Fornitore', cellClassName: 'text-left' }, // Assumendo che la SP fornisca questo campo
    { key: 'stato', label: 'Stato', cellClassName: 'text-center' },
  ], []);

  // Colonne per la tabella delle righe d'ordine
  const detailColumns = useMemo(() => [
    { key: 'id', label: 'ID Riga', cellClassName: 'text-center' },
    { key: 'id_articolo', label: 'ID Articolo', cellClassName: 'text-center' },
    { key: 'nome_articolo', label: 'Nome Articolo', cellClassName: 'text-left' }, // Assumendo che la SP fornisca questo
    { key: 'quantita', label: 'Quantità', cellClassName: 'text-right' },
    { key: 'prezzo_unitario', label: 'Prezzo', cellClassName: 'text-right' },
  ], []);

  // --- FUNZIONI DI FETCH ---
  const fetchOrdiniList = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      // Parametri di paginazione e ordinamento lato server
      const queryParams = {
        page: page + 1, // la SP usa 1-based index
        page_size: rowsPerPage,
        order_by: sortKey || 'num_ordine',
        order_dir: sortOrder,
      };

      const res = await ordiniApi.fetchAll(queryParams);

      if (!res || !res.rows) {
        console.warn('Risposta non valida dal server:', res);
        setOrdiniList([]);
        setTotalCount(0);
        return;
      }

      const formattedData = res.rows.map((o) => ({
        id: Number(o.id_ordine),
        num_ordine: String(o.num_ordine).trim(),
        data_ordine: new Date(o.data_ordine).toLocaleDateString('it-IT'),
        fornitore_id: Number(o.fornitore_id),
        stato: String(o.stato || '').trim(),
        note: o.note || '',
      }));

      setOrdiniList(formattedData);

      const total = res.meta?.totalRows || formattedData.length;
      setTotalCount(total);
      setTotalPages(Math.max(1, Math.ceil(total / rowsPerPage)));
    } catch (err) {
      setError(`Errore nel caricamento degli ordini: ${err.message}`);
      setOrdiniList([]);
      setTotalCount(0);
    } finally {
      setLoading(false);
    }
  }, [page, rowsPerPage, sortKey, sortOrder]);

  // Fetch iniziale della lista ordini
  useEffect(() => {
    fetchOrdiniList();
  }, [fetchOrdiniList]);

  const sortedOrdini = useMemo(() => {
    const sorted = [...ordiniList].sort((a, b) => {
      const valA = a[sortKey];
      const valB = b[sortKey];

      // Aggiungiamo un caso specifico per 'num_ordine' per forzare l'ordinamento numerico
      if (sortKey === 'num_ordine') {
        const numA = parseInt(valA, 10);
        const numB = parseInt(valB, 10);
        return sortOrder === 'asc' ? numA - numB : numB - numA;
      }

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
  }, [ordiniList, sortKey, sortOrder]);

  // --- HANDLER RIGHE ORDINE ---
  const handleNuovaRiga = () => {
    if (!selectedOrdine) {
      alert("Seleziona un ordine per aggiungere una riga.");
      return;
    }
    setEditingRiga({ id_ordine: selectedOrdine.id }); // Passa l'ID dell'ordine corrente
    setIsRigaDialogOpen(true);
  };

  const handleModificaRiga = () => {
    if (selectedDetailIds.length !== 1) {
      alert("Seleziona una riga da modificare.");
      return;
    }
    const rigaId = selectedDetailIds[0];
    const rigaToEdit = ordineRighe.find(r => r.id === rigaId);
    setEditingRiga(rigaToEdit);
    setIsRigaDialogOpen(true);
  };

  const handleEliminaRiga = async () => {
    if (selectedDetailIds.length === 0) {
        alert("Seleziona una o più righe da eliminare.");
        return;
    }

    if (window.confirm(`Sei sicuro di voler eliminare ${selectedDetailIds.length} riga/e?`)) {
        setLoading(true);
        setError('');
        try {
            // Usiamo Promise.all per gestire più cancellazioni in parallelo
            await Promise.all(selectedDetailIds.map(id => ordiniRigheApi.remove(id)));
            setMessage('✅ Righe eliminate con successo!');
            
            // Ricarica le righe dell'ordine corrente e pulisci la selezione
            handleOrdineSelect(selectedOrdine.id);
            setSelectedDetailIds([]);
            
        } catch (err) {
            setError(`❌ Errore durante l'eliminazione delle righe: ${err.message}`);
        } finally {
            setLoading(false);
        }
    }
  };

  const handleSalvaRiga = async (rigaData) => {
    setLoading(true);
    setError('');
    try {
        if (rigaData.id) {
            // Aggiornamento
            await ordiniRigheApi.update(rigaData.id, rigaData);
            setMessage('✅ Riga aggiornata con successo!');
        } else {
            // Inserimento
            await ordiniRigheApi.insert({ ...rigaData, id_ordine: selectedOrdine.id });
            setMessage('✅ Riga creata con successo!');
        }
        // Chiudi il dialog e ricarica le righe
        setIsRigaDialogOpen(false);
        setEditingRiga(null);
        handleOrdineSelect(selectedOrdine.id);
    } catch (err) {
        setError(`❌ Errore nel salvataggio della riga: ${err.message}`);
    } finally {
        setLoading(false);
    }
  };


  // --- GESTORI EVENTI ---
  const handleNewOrdine = useCallback(() => {
    // Prepara un oggetto vuoto per la creazione di un nuovo ordine
    const newOrdineTemplate = {
      id: null, // L'ID sarà null per un nuovo record
      ordine_num: '',
      data_ordine: new Date().toISOString().split('T')[0], // Data di oggi come default
      fornitore_id: '',
      stato: 'Aperto', // Stato di default
      note: ''
    };
    setSelectedOrdine(newOrdineTemplate);
    setOrdineRighe([]); // Le righe sono ovviamente vuote
    setSelectedDetailIds([]); // Pulisce la selezione delle righe
    setIsEditing(true); // Attiva HeadDocument in modalità modifica/creazione
  }, []);

  // Modifica: handler asincrono per edit da Header
  const handleEditFromHeader = useCallback(async () => {
    if (selectedMasterIds.length === 0) {
      alert("Seleziona un ordine da modificare");
      return;
    }
    if (selectedMasterIds.length > 1) {
      alert("Puoi modificare solo un ordine alla volta dall'header. Seleziona una singola riga.");
      return;
    }
    const ordineId = selectedMasterIds[0];
    setLoading(true);
    setError('');
    try {
      /*
       * 1. Recuperiamo i dati dell'ordine dal dataset già in memoria (ordiniList).
       *    In questo modo evitiamo di invocare un endpoint non ancora disponibile
       *    come /orders/:id che genererebbe un 404.
       */
      const ordineSelezionato = ordiniList.find((o) => o.id === ordineId);
      if (!ordineSelezionato) {
        throw new Error(`Ordine con ID ${ordineId} non trovato nella tabella.`);
      }

      // Normalizza la data per l'input type="date" (YYYY-MM-DD)
      let dataISO = ordineSelezionato.data_ordine;
      if (typeof dataISO === 'string' && dataISO.includes('/')) {
        const [gg, mm, aa] = dataISO.split('/');
        dataISO = `${aa}-${mm.padStart(2, '0')}-${gg.padStart(2, '0')}`;
      }

      const testata = {
        id: ordineSelezionato.id,
        num_ordine: ordineSelezionato.num_ordine,
        data_ordine: dataISO,
        fornitore_id: ordineSelezionato.fornitore_id,
        stato: ordineSelezionato.stato,
        note: ordineSelezionato.note,
      };

      // 2. Recuperiamo le righe dell'ordine da backend (endpoint esistente)

      const righeResponse = await ordiniRigheApi.fetchByOrdineId(ordineId);
      const righe = Array.isArray(righeResponse)
        ? righeResponse
        : righeResponse?.rows || [];

      setSelectedOrdine(testata);
      setOrdineRighe(righe);
      setSelectedDetailIds([]);
      setIsEditing(true); // Attiva HeadDocument in modifica
      setSelectedMasterIds([]); // Pulisce la selezione dopo l'edit
    } catch (err) {
      setError(`Errore nel caricamento dei dettagli dell'ordine: ${err.message}`);
      setSelectedOrdine(null);
      setOrdineRighe([]);
      setIsEditing(false);
      setSelectedMasterIds([]);
    } finally {
      setLoading(false);
    }
  }, [selectedMasterIds, ordiniList]);

  const handleOrdineSelect = useCallback(async (ordineId) => {
    if (!ordineId) {
      setSelectedOrdine(null);
      setOrdineRighe([]);
      setIsEditing(false);
      return;
    }

    setLoading(true);
    setError('');
    try {
      // Recupera la testata dall'elenco ordini già in memoria
      const ordineSelezionato = ordiniList.find((o) => o.id === ordineId);
      if (!ordineSelezionato) {
        throw new Error(`Ordine con ID ${ordineId} non trovato nella tabella.`);
      }

      // Normalizza la data per HeadDocument (YYYY-MM-DD)
      let dataISO = ordineSelezionato.data_ordine;
      if (typeof dataISO === 'string' && dataISO.includes('/')) {
        const [gg, mm, aa] = dataISO.split('/');
        dataISO = `${aa}-${mm.padStart(2, '0')}-${gg.padStart(2, '0')}`;
      }

      const testata = {
        id: ordineSelezionato.id,
        num_ordine: ordineSelezionato.num_ordine,
        data_ordine: dataISO,
        fornitore_id: ordineSelezionato.fornitore_id,
        stato: ordineSelezionato.stato,
        note: ordineSelezionato.note,
      };

      // Recupera le righe dal backend
      const righeResponse = await ordiniRigheApi.fetchByOrdineId(ordineId);
      const righe = Array.isArray(righeResponse)
        ? righeResponse
        : righeResponse?.rows || [];

      setSelectedOrdine(testata);
      setOrdineRighe(righe);
      setSelectedDetailIds([]); // Pulisce la selezione delle righe quando si cambia ordine
      setIsEditing(false); // Quando selezioni, non sei in modifica
    } catch (err) {
      setError(`Errore nel caricamento dei dettagli dell'ordine: ${err.message}`);
      setSelectedOrdine(null);
      setOrdineRighe([]);
      setIsEditing(false);
    } finally {
      setLoading(false);
    }
  }, [ordiniList]);

  // In modifica si attiva HeadDocument
  const handleEdit = useCallback((item) => {
    setSelectedOrdine(item);
    setSelectedDetailIds([]);
    setSelectedMasterIds([]);
    setIsEditing(true); // Attiva HeadDocument in modifica
  }, []);

  const handleBackToMaster = () => {
    setSelectedOrdine(null);
    setOrdineRighe([]);
    setSelectedMasterIds([]); // Pulisce la selezione master
    setSelectedDetailIds([]); // Pulisce la selezione detail
    setIsEditing(false); // Esci dalla modalità modifica
  };

  const handleSaveOrdine = useCallback(async () => {
    if (!selectedOrdine) {
      setError("Nessun ordine da salvare.");
      return;
    }

    // Aggiungi qui una validazione più robusta se necessario
    if (!selectedOrdine.num_ordine || !selectedOrdine.data_ordine || !selectedOrdine.fornitore_id || !selectedOrdine.stato) {
      setError("Compila tutti i campi obbligatori della testata (Numero, Data, Fornitore, Stato).");
      return;
    }

    setLoading(true);
    setError('');
    setMessage('');
    try {
      if (selectedOrdine.id) {
        // Modalità UPDATE
        await ordiniApi.update(selectedOrdine.id, selectedOrdine);
        setMessage('✅ Ordine aggiornato con successo!');
      } else {
        // Modalità CREATE
        const { id, ...dataToInsert } = selectedOrdine; // Rimuovi l'ID nullo
        console.log(dataToInsert);
        await ordiniApi.insert(dataToInsert);
        setMessage('✅ Ordine creato con successo!');
      }
      // Dopo il salvataggio, ricarica la lista e torna alla vista master
      fetchOrdiniList();
      handleBackToMaster();
    } catch (err) {
      console.log(dataToInsert);
      setError(`❌ Errore nel salvataggio dell'ordine: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, [selectedOrdine, fetchOrdiniList, handleBackToMaster]);

  const handleHeadChange = useCallback((updatedHeadData) => {
    setSelectedOrdine(prev => ({ ...prev, ...updatedHeadData }));
  }, []);

  // Handler per la selezione delle righe nella tabella master
  const handleMasterSelectionChange = useCallback((id, checked) => {
    setSelectedMasterIds((prev) =>
      checked ? [...prev, id] : prev.filter((selId) => selId !== id)
    );
  }, []);

  // Handler per la selezione delle righe nella tabella detail
  const handleDetailSelectionChange = useCallback((id, checked) => {
    setSelectedDetailIds((prev) =>
      checked ? [...prev, id] : prev.filter((selId) => selId !== id)
    );
  }, []);

  // --- DATI PER LA VISUALIZZAZIONE ---
  const currentTableData = sortedOrdini; // dati già paginati dal backend

  // Definisci i campi per il filtro dei ricambi
  const ordiniFilterFields = useMemo(
    () => [
      {
        name: "num_ordine",
        label: "Numero ordine",
        type: "text",
        placeholder: "Cerca per numero ordine...",
      },
      {
        name: "fornitore_id",
        label: "Descrizione",
        type: "text",
        placeholder: "Cerca per fornitore...",
      },
      {
        name: "stato",
        label: "Stato ordine",
        type: "text",
        placeholder: "Cerca per stato ordine...",
      },
      // Aggiungi altri campi se necessario, es. per quantità min/max se l'API lo supporta
    ],
    []
  );
  // --- GESTORI RICERCA ---
  // Funzione per gestire la ricerca dei ricambi
  const handleSearchOrdini = async (filterValues) => {
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

      const resultsFromSearch = await ordiniApi.fetchByFilters(queryParams);

      if (resultsFromSearch && Array.isArray(resultsFromSearch.rows)) {
        setOrdiniList(resultsFromSearch.rows);
        setTotalCount(resultsFromSearch.meta?.totalRows || resultsFromSearch.rows.length);
        setPage(0); // resetta alla prima pagina
        if (resultsFromSearch.rows.length === 0) {
          setMessage("ℹ️ Nessun ordine trovato con i filtri specificati.");
        }
      } else {
        throw new Error(
          resultsFromSearch?.error || "Dati filtrati non validi."
        );
      }
    } catch (err) {
      console.error("Errore nella ricerca ordini:", err);
      setMessage(`❌ Errore ricerca ordini: ${err.message || err}`);
      setOrdiniList([]);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="ordini-container">
      <Header
        currentUser={currentUser}
        onAdd={handleNewOrdine}
        onEdit={handleEditFromHeader}
        onDelete={() => {}}
        onSearch={toggleSearchPanel}
        showSearchPanel={showSearch}
        onBack={selectedOrdine ? handleBackToMaster : null}
      />

      {error && <div className="error-message">{error}</div>}
      {message && <div className="success-message">{message}</div>}

      {showSearch && (
        <FilterSearch
          schema={orderSchema}
          uiHints={orderUiHints}
          onSearch={() => {}}
          onReset={() => {}}
        />
      )}

      {loading && <div className="loader">Caricamento...</div>}

      <div className="ordini-content">
        {!selectedOrdine ? (
          // --- VISTA MASTER (LISTA ORDINI) ---
          <div className="master-view">
            <TableGrid
              columns={masterColumns}
              rows={sortedOrdini}
              sortKey={sortKey}
              sortOrder={sortOrder}
              onSort={toggleSort}
              selectedIds={selectedMasterIds}
              onRowSelect={handleMasterSelectionChange}
              onRowDoubleClick={(id) => handleOrdineSelect(id)}
            />
            <Pagination
              page={page}
              totalPages={totalPages}
              onPageChange={setPage}
            />
          </div>
        ) : isEditing ? (
          // --- VISTA MODIFICA/CREAZIONE TESTATA ---
          <DocumentHeaderForm
            schema={orderSchema}
            uiHints={orderUiHints}
            initialData={selectedOrdine}
            onChange={handleHeadChange}
            onSave={handleSaveOrdine}
            onCancel={handleBackToMaster}
          />
        ) : (
          // --- VISTA DETAIL (TESTATA + RIGHE) ---
          <div className="detail-view">
            <DocumentHeaderForm
              schema={orderSchema}
              uiHints={orderUiHints}
              initialData={selectedOrdine}
              isReadOnly={true} // in sola lettura
            />
            <div className="detail-actions">
                <button onClick={handleNuovaRiga} className="btn-action">Aggiungi Riga</button>
                <button onClick={handleModificaRiga} disabled={selectedDetailIds.length !== 1} className="btn-action">Modifica Riga</button>
                <button onClick={handleEliminaRiga} disabled={selectedDetailIds.length === 0} className="btn-action btn-danger">Elimina Riga</button>
            </div>
            <TableGrid
              columns={detailColumns}
              rows={ordineRighe}
              onSort={() => {}} // L'ordinamento delle righe non è implementato
              selectedIds={selectedDetailIds}
              onRowSelect={handleDetailSelectionChange}
            />
          </div>
        )}
      </div>
        {/* Dialog per l'inserimento/modifica delle righe */}
        <OrdineRigaDialog
            open={isRigaDialogOpen}
            riga={editingRiga}
            onSave={handleSalvaRiga}
            onClose={() => {
                setIsRigaDialogOpen(false);
                setEditingRiga(null);
            }}
        />
    </div>
  );
};

export default Ordini;
