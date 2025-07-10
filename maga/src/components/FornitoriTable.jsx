//=================================
//File: FornitoriTable.jsx
//Componente per la gestione dei fornitori.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-10"
//==================================
import React, { useState, useEffect, useMemo, useCallback } from 'react';
import debounce from 'lodash/debounce';
import DialogCustom from './DialogCustom';
import fornitoriApi from '../api/fornitoriApi'; // API per i fornitori
import Header from './Header';
import TableGrid from './TableGrid';
import HeadDocument from './HeadDocument2';
import Pagination from './Pagination1';
import FilterSearch from './FilterSearch';
import '../css/Ordini.css';

const rowsPerPageOptions = [5, 10, 20, 50];

const FornitoriTable = ({ currentUser, currentLocation, onLogout }) => {
  const [fornitoriList, setFornitoriList] = useState([]);
  const [selectedFornitore, setSelectedFornitore] = useState(null);
  const [selectedIds, setSelectedIds] = useState([]);
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

  const masterColumns = useMemo(() => [
    { key: 'id', label: 'ID', cellClassName: 'text-center' },
    { key: 'codice', label: 'Codice', cellClassName: 'text-left' },
    { key: 'rag_soc', label: 'Ragione Sociale', cellClassName: 'text-left' },
    { key: 'partita_iva', label: 'Partita IVA', cellClassName: 'text-left' },
    { key: 'telefono', label: 'Telefono', cellClassName: 'text-left' },
    { key: 'email', label: 'Email', cellClassName: 'text-left' },
    { key: 'citta', label: 'Città', cellClassName: 'text-left' },
  ], []);

  const headDocumentConfig = useMemo(() => ({
    titolo: "Dettaglio Fornitore",
    fields: [
      { name: 'codice', label: 'Codice', type: 'text', required: true, maxLength: 10 },
      { name: 'rag_soc', label: 'Ragione Sociale', type: 'text', required: true, maxLength: 255 },
      { name: 'partita_iva', label: 'Partita IVA', type: 'text', maxLength: 20 },
      { name: 'indirizzo', label: 'Indirizzo', type: 'text', maxLength: 255 },
      { name: 'citta', label: 'Città', type: 'text', maxLength: 100 },
      { name: 'cap', label: 'CAP', type: 'text', maxLength: 10 },
      { name: 'provincia', label: 'Provincia', type: 'text', maxLength: 2 },
      { name: 'nazione', label: 'Nazione', type: 'text', maxLength: 50, defaultValue: 'Italia' },
      { name: 'telefono', label: 'Telefono', type: 'text', maxLength: 20 },
      { name: 'email', label: 'Email', type: 'email', maxLength: 100 },
      { name: 'sito_web', label: 'Sito Web', type: 'text', maxLength: 100 },
      { name: 'note', label: 'Note', type: 'textarea' },
    ]
  }), []);

  const filterFields = useMemo(() => [
    { name: 'codice', label: 'Codice', type: 'text', placeholder: 'Cerca per codice...' },
    { name: 'rag_soc', label: 'Ragione Sociale', type: 'text', placeholder: 'Cerca per ragione sociale...' },
    { name: 'partita_iva', label: 'Partita IVA', type: 'text', placeholder: 'Cerca per partita IVA...' },
    { name: 'citta', label: 'Città', type: 'text', placeholder: 'Cerca per città...' },
    { name: 'email', label: 'Email', type: 'text', placeholder: 'Cerca per email...' },
  ], []);

  const fetchFornitori = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const data = await fornitoriApi.fetchAll();
      setFornitoriList(data);
    } catch (err) {
      setError(`Errore nel caricamento fornitori: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    fetchFornitori();
  }, [fetchFornitori]);

  const sortedFornitori = useMemo(() => {
    const sorted = [...fornitoriList].sort((a, b) => {
      const valA = a[sortKey];
      const valB = b[sortKey];
      if (typeof valA === "string" && typeof valB === "string") {
        return sortOrder === "asc" ? valA.localeCompare(valB) : valB.localeCompare(valA);
      }
      if (typeof valA === "number" && typeof valB === "number") {
        return sortOrder === "asc" ? valA - valB : valB - valA;
      }
      return 0;
    });
    return sorted;
  }, [fornitoriList, sortKey, sortOrder]);

  const handleNewFornitore = () => {
    setError('');
    setMessage('');
    setSelectedFornitore({
      id: null,
      codice: '',
      ragione_sociale: '',
      partita_iva: '',
      indirizzo: '',
      citta: '',
      cap: '',
      provincia: '',
      nazione: 'Italia',
      telefono: '',
      email: '',
      sito_web: '',
      note: '',
    });
  };

  const handleFornitoreSelect = async (fornitoreId) => {
    if (!fornitoreId) {
      setSelectedFornitore(null);
      return;
    }
    setLoading(true);
    setError('');
    setMessage('');
    try {
      const fornitore = await fornitoriApi.fetchById(fornitoreId);
      setSelectedFornitore(fornitore);
    } catch (err) {
      setError(`Errore nel caricamento fornitore: ${err.message}`);
      setSelectedFornitore(null);
    } finally {
      setLoading(false);
    }
  };

  const handleBackToMaster = () => {
    setSelectedFornitore(null);
    setSelectedIds([]);
    setError('');
    setMessage('');
  };

  const handleSaveFornitore = async () => {
    if (!selectedFornitore) return;
    if (!selectedFornitore.codice || !selectedFornitore.ragione_sociale) {
      setError("Compila i campi obbligatori (Codice, Ragione Sociale).");
      return;
    }
    setLoading(true);
    setError('');
    setMessage('');
    try {
      if (selectedFornitore.id) {
        await fornitoriApi.update(selectedFornitore.id, selectedFornitore);
        setMessage('✅ Fornitore aggiornato con successo!');
      } else {
        await fornitoriApi.insert(selectedFornitore);
        setMessage('✅ Fornitore creato con successo!');
      }
      await fetchFornitori();
      handleBackToMaster();
    } catch (err) {
      setError(`❌ Errore nel salvataggio fornitore: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const handleDeleteFornitore = () => {
    if (selectedIds.length === 0) {
      setError("Nessun fornitore selezionato per l'eliminazione.");
      return;
    }
    setShowDeleteDialog(true);
  };

  const confirmDeleteFornitori = async () => {
    setShowDeleteDialog(false);
    setLoading(true);
    setError('');
    setMessage('');
    try {
      await Promise.all(selectedIds.map(id => fornitoriApi.delete(id)));
      setMessage(`✅ ${selectedIds.length} fornitori eliminati con successo!`);
      await fetchFornitori();
      setSelectedIds([]);
    } catch (err) {
      setError(`❌ Errore eliminazione: ${err.message}`);
    } finally {
      setLoading(false);
    }
  };

  const handleSearchFornitori = useCallback(async (filterValues) => {
    setLoading(true);
    setMessage('');
    try {
      const results = await fornitoriApi.fetchByFilters(filterValues);
      setFornitoriList(results);
      if (results.length === 0) {
        setMessage("ℹ️ Nessun fornitore trovato.");
      }
    } catch (err) {
      setError(`❌ Errore ricerca: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, []);

  const handleSearchDebounced = useMemo(() => debounce(handleSearchFornitori, 500), []);

  useEffect(() => {
    return () => handleSearchDebounced.cancel();
  }, []);

  const handleHeadChange = useCallback((updatedData) => {
    setSelectedFornitore(prev => ({ ...prev, ...updatedData }));
  }, []);

  const handleSelectionChange = useCallback((id, checked) => {
    setSelectedIds(prev => checked ? [...prev, id] : prev.filter(selId => selId !== id));
  }, []);

  const paginatedFornitoriList = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    return sortedFornitori.slice(firstPageIndex, firstPageIndex + rowsPerPage);
  }, [page, rowsPerPage, sortedFornitori]);

  return (
    <>
      <Header
        onBack={selectedFornitore ? handleBackToMaster : null}
        onAdd={!selectedFornitore ? handleNewFornitore : null}
        onSave={selectedFornitore ? handleSaveFornitore : null}
        onDelete={!selectedFornitore && selectedIds.length > 0 ? handleDeleteFornitore : null}
        onSearch={!selectedFornitore ? toggleSearchPanel : null}
        currentUser={currentUser}
        currentLocation={currentLocation}
        onLogout={onLogout}
      />
      <div className="container">
        <h1 className="title-gestione-ordini">Gestione Fornitori</h1>
        {error && <div className="message-error">{error}</div>}
        {message && <div className="message-success">{message}</div>}

        {selectedFornitore ? (
          <HeadDocument
            config={headDocumentConfig}
            initialData={selectedFornitore}
            onChange={handleHeadChange}
            readOnly={false}
          />
        ) : (
          <>
            {showSearch && (
              <FilterSearch
                fields={filterFields}
                onSearch={handleSearchDebounced}
              />
            )}
            <div className="table-wrapper">
              <TableGrid
                columns={masterColumns}
                rows={paginatedFornitoriList}
                onRowClick={handleFornitoreSelect}
                selectedIds={selectedIds}
                onSelectionChange={handleSelectionChange}
                onSort={toggleSort}
                sortKey={sortKey}
                sortOrder={sortOrder}
                loading={loading}
              />
              <div className="pagination-bar">
                <Pagination
                currentPage={page + 1}
                totalCount={fornitoriList.length}
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
            </div>
          </>
        )}
      </div>
      <DialogCustom
        open={showDeleteDialog}
        title="Conferma eliminazione"
        content={`Sei sicuro di voler eliminare ${selectedIds.length} fornitori?`}
        onClose={() => setShowDeleteDialog(false)}
        onConfirm={confirmDeleteFornitori}
      />
    </>
  );
};

export default FornitoriTable;
