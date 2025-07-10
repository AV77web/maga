//=================================
//File: ClientiTable.jsx
//Componente per la gestione dei clienti.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-08"
//==================================
import React, { useState, useEffect, useMemo, useCallback } from 'react';
import debounce from 'lodash/debounce';
import DialogCustom from './DialogCustom';
import clientiApi from '../api/clientiApi'; // Assumo esista un API per i clienti
import Header from './Header';
import TableGrid from './TableGrid';
import HeadDocument from './HeadDocument2'; // Usiamo la versione più recente
import Pagination from './Pagination1';
import FilterSearch from './FilterSearch';
import '../css/Ordini.css'; // Riusiamo lo stile per coerenza

const rowsPerPageOptions = [5, 10, 20, 50];

const ClientiTable = ({ currentUser, currentLocation, onLogout }) => {
  // --- STATI ---
  const [clientiList, setClientiList] = useState([]);
  const [selectedCliente, setSelectedCliente] = useState(null); // Cliente selezionato per la modifica/visualizzazione
  const [selectedIds, setSelectedIds] = useState([]); // ID selezionati nella tabella
  const [sortKey, setSortKey] = useState(null);
  const [sortOrder, setSortOrder] = useState("asc");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [showSearch, setShowSearch] = useState(false);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);

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
  // Colonne per la tabella dei clienti
  const masterColumns = useMemo(() => [
    { key: 'id', label: 'ID', cellClassName: 'text-center' },
    { key: 'codice', label: 'Codice', cellClassName: 'text-left' },
    { key: 'nome', label: 'Nome', cellClassName: 'text-left' },
    { key: 'tipo_cliente', label: 'Tipo', cellClassName: 'text-center' },
    { key: 'citta', label: 'Città', cellClassName: 'text-left' },
    { key: 'telefono', label: 'Telefono', cellClassName: 'text-left' },
    { key: 'email', label: 'Email', cellClassName: 'text-left' },
  ], []);

  // Configurazione per il componente HeadDocument
  const headDocumentConfig = useMemo(() => ({
    titolo: "Dettaglio Cliente",
    fields: [
      { name: 'codice', label: 'Codice', type: 'text', required: true, maxLength: 10 },
      { name: 'nome', label: 'Nome/Ragione Sociale', type: 'text', required: true, maxLength: 255 },
      { name: 'tipo_cliente', label: 'Tipo Cliente', type: 'select', options: ['Privato', 'Azienda'], required: true },
      { name: 'partita_iva', label: 'Partita IVA', type: 'text', maxLength: 20 },
      { name: 'cf', label: 'Codice Fiscale', type: 'text', maxLength: 20 },
      { name: 'indirizzo', label: 'Indirizzo', type: 'text', maxLength: 255 },
      { name: 'citta', label: 'Città', type: 'text', maxLength: 100 },
      { name: 'cap', label: 'CAP', type: 'text', maxLength: 10 },
      { name: 'pv', label: 'Provincia', type: 'text', maxLength: 2 },
      { name: 'nazione', label: 'Nazione', type: 'text', maxLength: 50 },
      { name: 'telefono', label: 'Telefono', type: 'text', maxLength: 20 },
      { name: 'email', label: 'Email', type: 'email', maxLength: 100 },
      { name: 'sito_web', label: 'Sito Web', type: 'text', maxLength: 100 },
      { name: 'contatto', label: 'Contatto', type: 'text', maxLength: 100 },
      { name: 'note', label: 'Note', type: 'textarea' },
    ]
  }), []);

  // Configurazione per il componente FilterSearch
  const filterFields = useMemo(() => [
    { name: 'codice', label: 'Codice', type: 'text', placeholder: 'Cerca per codice...' },
    { name: 'nome', label: 'Nome', type: 'text', placeholder: 'Cerca per nome...' },
    { name: 'citta', label: 'Città', type: 'text', placeholder: 'Cerca per città...' },
    { name: 'tipo_cliente', label: 'Tipo Cliente', type: 'select', options: ['Privato', 'Azienda'], placeholder: '-- Seleziona Tipo --' },
  ], []);

  // --- FUNZIONI DI FETCH ---
  const fetchClienti = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const data = await clientiApi.fetchAll();
      setClientiList(data);
    } catch (err) {
      setError(`Errore nel caricamento dei clienti: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchClienti();
  }, [fetchClienti]);

  const sortedClienti = useMemo(() => {
    const sorted = [...clientiList].sort((a, b) => {
      const valA = a[sortKey];
      const valB = b[sortKey];

    // Aggiungiamo un caso specifico per 'num_ordine' per forzare l'ordinamento numerico
    if (sortKey === 'codice') {
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
  }, [clientiList, sortKey, sortOrder]);

  // --- GESTORI EVENTI ---
  const handleNewCliente = useCallback(() => {
    setError('');
    setMessage('');
    setSelectedCliente({
      id: null,
      codice: '',
      nome: '',
      tipo_cliente: 'Privato',
      partita_iva: '',
      cf: '',
      indirizzo: '',
      citta: '',
      cap: '',
      pv: '',
      nazione: 'Italia',
      telefono: '',
      email: '',
      sito_web: '',
      note: '',
      contatto: '',
    });
  }, []);

  const handleClienteSelect = useCallback(async (clienteId) => {
    if (!clienteId) {
      setSelectedCliente(null);
      return;
    }
    
    setError('');
    setMessage('');
    setLoading(true);
    try {
      const cliente = await clientiApi.fetchById(clienteId);
      setSelectedCliente(cliente);
    } catch (err) {
      setError(`Errore nel caricamento del cliente: ${err.message}`);
      setSelectedCliente(null);
    } finally {
      setLoading(false);
    }
  }, []);

  const handleBackToMaster = () => {
    setSelectedCliente(null);
    setSelectedIds([]);
    setError('');
    setMessage('');
  };

  const handleSaveCliente = useCallback(async () => {
    if (!selectedCliente) {
      setError("Nessun cliente da salvare.");
      return;
    }

    if (!selectedCliente.codice || !selectedCliente.nome) {
      setError("Compila i campi obbligatori (Codice, Nome).");
      return;
    }

    setLoading(true);
    setError('');
    setMessage('');
    try {
      if (selectedCliente.id) {
        await clientiApi.update(selectedCliente.id, selectedCliente);
        setMessage('✅ Cliente aggiornato con successo!');
      } else {
        const { id, ...dataToInsert } = selectedCliente;
        await clientiApi.insert(dataToInsert);
        setMessage('✅ Cliente creato con successo!');
      }
      await fetchClienti();
      handleBackToMaster();
    } catch (err) {
      setError(`❌ Errore nel salvataggio del cliente: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, [selectedCliente, fetchClienti]);

  const handleDeleteCliente = useCallback(async () => {
    if (selectedIds.length === 0) {
      setError("Nessun cliente selezionato per l'eliminazione.");
      return;
    }
    setShowDeleteDialog(true);
  }, [selectedIds]);

  const confirmDeleteClienti = async () => {
    setShowDeleteDialog(false);
    setLoading(true);
    setError('');
    setMessage('');
    try {
      await Promise.all(selectedIds.map(id => clientiApi.delete(id)));
      setMessage(`✅ ${selectedIds.length} clienti eliminati con successo!`);
      await fetchClienti();
      setSelectedIds([]);
    } catch (err) {
      setError(`❌ Errore durante l'eliminazione: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

 // Definisci i campi per il filtro dei ricambi
  const clientiFilterFields = useMemo(
    () => [
      {
        name: "codice",
        label: "Codice Cliente",
        type: "text",
        placeholder: "Cerca per codice...",
      },
      
      {
        name: "name",
        label: "Nome",
        type: "text",
        placeholder: "Cerca per nome...",
      },
      {
        name: "tipo_cliente",
        label: "Tipo cliente",
        type: "select",
        options: [
          { value: "Privato", label: "Privato" },
          { value: "Azienda", label: "Azienda" }
        ],
        placeholder: "-- Seleziona Tipo --",
      },
      {
        name: "partita_iva",
        label: "Partita IVA",
        type: "text",
        placeholder: "Cerca per prtita iva...",
      },
      {
        name: "citta",
        label: "Citta",
        type: "text",
        placeholder: "Cerca per città...",
      },
      {
        name: "cf",
        label: "Codice Fiscale",
        type: "text",
        placeholder: "Cerca per codice fiscale...",
      },
      {
        name: "contatto",
        label: "Contatto",
        type: "text",
        placeholder: "Cerca per contatto...",
      },
      {
        name: "email",
        label: "Email",
        type: "text",
        placeholder: "Cerca per email...",
      },
      // Aggiungi altri campi se necessario, es. per quantità min/max se l'API lo supporta
    ],
    []
  );


  /*const handleSearchClienti = useCallback(async (filters) => {
    setLoading(true);
    setError('');
    try {
      const data = await clientiApi.fetchByFilters(filters);
      setClientiList(data);
      setPage(0); // Reset to first page after search
    } catch (err) {
      setError(`Errore nella ricerca: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, []);*/

    // Funzione per gestire la ricerca dei clienti
  const handleSearchClienti = useCallback(async (filterValues) => {
    // Funzione unificata per ricerca e aggiornamento stato
    setLoading(true);
    setMessage("");
    try {
      const resultsFromSearch = await clientiApi.fetchByFilters(filterValues);
      if (Array.isArray(resultsFromSearch)) {
        setClientiList(resultsFromSearch); // Aggiorna lo stato con i risultati
        if (resultsFromSearch.length === 0) {
          setMessage("ℹ️ Nessun ordine trovato con i filtri specificati.");
        }
      } else {
        throw new Error(resultsFromSearch.error || "Dati filtrati non validi.");
      }
    } catch (err) {
      console.error("Errore nella ricerca clienti:", err);
      setMessage(`❌ Errore ricerca clienti: ${err.message || err}`);
      setClientiList([]);
    } finally {
      setLoading(false);
    }
  }, []);

  const handleSearchDebounced = useMemo(
    () => debounce(handleSearchClienti, 500),
    []
  );

  useEffect(() => {
  return () => {
    handleSearchDebounced.cancel();
  };
}, []);

  const handleHeadChange = useCallback((updatedData) => {
    setSelectedCliente(prev => ({ ...prev, ...updatedData }));
  }, []);

  const handleSelectionChange = useCallback((id, checked) => {
    setSelectedIds((prev) =>
      checked ? [...prev, id] : prev.filter((selId) => selId !== id)
    );
  }, []);

  // --- DATI PER LA VISUALIZZAZIONE ---
  const paginatedClientiList = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return sortedClienti.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, sortedClienti]);

  

  return (
    <>
      <Header
        onBack={selectedCliente ? handleBackToMaster : null}
        onAdd={!selectedCliente ? handleNewCliente : null}
        onSave={selectedCliente ? handleSaveCliente : null}
        onDelete={!selectedCliente && selectedIds.length > 0 ? handleDeleteCliente : null}
        onSearch={!selectedCliente ? () => setShowSearch(prev => !prev) : null}
        currentUser={currentUser}
        currentLocation={currentLocation}
        onLogout={onLogout}
      />
      <div className="container">
       
        <h1 className="title-gestione-ordini">Gestione Clienti</h1>
        {error && <div className="message-error">{error}</div>}
        {message && <div className="message-success">{message}</div>}

        {selectedCliente ? (
          // --- VISTA DETAIL (MODIFICA/INSERIMENTO) ---
          <HeadDocument
            config={headDocumentConfig}
            initialData={selectedCliente}
            onChange={handleHeadChange}
            readOnly={false}
          />
        ) : (
          // --- VISTA MASTER (LISTA) ---
          <>
            {showSearch && (
              <FilterSearch
                fields={clientiFilterFields}
                onSearch={handleSearchDebounced}
              />
            )}
            <div className="table-wrapper">
              <TableGrid
                columns={masterColumns}
                rows={paginatedClientiList}
                selectedIds={selectedIds}
                loading={loading}
                onRowSelectionChange={handleSelectionChange}
                onRowClick={(rowId) => handleClienteSelect(rowId)}
                sortKey={sortKey}
                sortOrder={sortOrder}
                onSort={toggleSort}
              />
            </div>
            <div className="pagination-bar">
              <Pagination
                currentPage={page + 1}
                totalCount={clientiList.length}
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
          </>
        )}
      </div>
      <DialogCustom
        open={showDeleteDialog}
        title="Conferma eliminazione"
        message={`Confermi l'eliminazione di ${selectedIds.length} clienti?`}
        onConfirm={confirmDeleteClienti}
        onCancel={() => setShowDeleteDialog(false)}
      />
    </>
  );
};

export default ClientiTable;

