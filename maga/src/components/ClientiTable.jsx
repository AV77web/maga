//=================================
//File: ClientiTable.jsx
//Componente per la gestione dei clienti.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-08"
//==================================
import React, { useState, useEffect, useMemo, useCallback } from 'react';
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

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [message, setMessage] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [showSearch, setShowSearch] = useState(false);

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

  // --- GESTORI EVENTI ---
  const handleNewCliente = useCallback(() => {
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
    setLoading(true);
    setError('');
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
    if (!window.confirm(`Confermi l'eliminazione di ${selectedIds.length} clienti?`)) {
      return;
    }

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
  }, [selectedIds, fetchClienti]);

  const handleSearch = useCallback(async (filters) => {
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
    return clientiList.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, clientiList]);

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
                fields={filterFields}
                onSearch={handleSearch}
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
              />
            </div>
            <div className="pagination-bar">
              <Pagination
                currentPage={page + 1}
                totalCount={clientiList.length}
                pageSize={rowsPerPage}
                onPageChange={(newPage) => setPage(newPage - 1)}
              />
            </div>
          </>
        )}
      </div>
    </>
  );
};

export default ClientiTable;

