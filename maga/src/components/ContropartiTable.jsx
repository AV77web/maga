//=================================
//File: ContropartiTable.jsx
//Componente unico per la gestione di CLIENTI e FORNITORI (controparti)
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-14"
//=================================
import React, { useState, useEffect, useMemo, useCallback } from 'react';
import DialogCustom from './DialogCustom';
import counterpartiesApi from '../api/counterpartiesApi';
import Header from './Header';
import HeadDocument from './HeadDocument2';
import TableGrid from './TableGrid';
import Pagination from './Pagination1';
import FilterSearch from './FilterSearch';
import '../css/Ordini.css';
import debounce from 'lodash/debounce';

const rowsPerPageOptions = [5, 10, 20, 50];

export default function ContropartiTable() {
  const [list, setList] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [sortKey, setSortKey] = useState('nome');
  const [sortOrder, setSortOrder] = useState('asc');
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const [filterData, setFilterData] = useState({});
  const [selectedItem, setSelectedItem] = useState(null);
  const [selectedIds, setSelectedIds] = useState([]);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [showSearch, setShowSearch] = useState(false);
  const [message, setMessage] = useState('');

  const columns = useMemo(() => [
    { key: 'id', label: 'ID', cellClassName: 'text-center' },
    { key: 'nome', label: 'Nome / Rag. Soc.', cellClassName: 'text-left' },
    { key: 'tipo', label: 'Tipo', cellClassName: 'text-center' },
    { key: 'citta', label: 'Città', cellClassName: 'text-left' },
    { key: 'telefono', label: 'Telefono', cellClassName: 'text-left' },
    { key: 'email', label: 'Email', cellClassName: 'text-left' },
  ], []);

  const filterFields = useMemo(() => [
    { name: 'nome', label: 'Nome', type: 'text', placeholder: 'Cerca per nome...' },
    { name: 'tipo', label: 'Tipo', type: 'select', options: ['CLIENTE', 'FORNITORE'], placeholder: '--Tipo--' },
    { name: 'citta', label: 'Città', type: 'text', placeholder: 'Cerca per città...' },
  ], []);

  const headDocumentConfig = useMemo(() => ({
    titolo: selectedItem?.id ? 'Modifica Controparte' : 'Nuova Controparte',
    fields: [
      { name: 'nome', label: 'Nome/Rag. Soc.', type: 'text', required: true, maxLength: 255 },
      { name: 'tipo', label: 'Tipo', type: 'select', options: ['CLIENTE','FORNITORE'], required: true },
      { name: 'codice_fiscale', label: 'Codice Fiscale', type: 'text', maxLength: 20, pattern: 'codiceFiscale' },
      { name: 'partita_iva', label: 'Partita IVA', type: 'text', maxLength: 20 },
      { name: 'indirizzo', label: 'Indirizzo', type: 'text', maxLength: 255 },
      { name: 'citta', label: 'Città', type: 'text', maxLength: 100 },
      { name: 'cap', label: 'CAP', type: 'text', maxLength: 5, pattern: 'cap' },
      { name: 'provincia', label: 'PV', type: 'text', maxLength: 2 },
      { name: 'nazione', label: 'Nazione', type: 'text', maxLength: 50 },
      { name: 'telefono', label: 'Telefono', type: 'text', maxLength: 20 },
      { name: 'email', label: 'Email', type: 'email', maxLength: 100 },
      { name: 'contatto', label: 'Contatto', type: 'text', maxLength: 100 },
      { name: 'note', label: 'Note', type: 'textarea' },
    ],
  }), [selectedItem]);

  const fetchData = useCallback(async () => {
    setLoading(true);
    try {
      const query = {
        page: page + 1,
        page_size: rowsPerPage,
        order_by: sortKey,
        order_dir: sortOrder,
        ...filterData,
      };
      const res = await counterpartiesApi.fetchByFilters(query);
      const rows = res.rows || res.result?.rows || [];
      const meta = res.meta || res.result?.meta || {};
      setList(rows);
      const total = meta.totalRows || rows.length;
      setTotalCount(total);
      setTotalPages(Math.max(1, Math.ceil(total / rowsPerPage)));
    } catch (err) {
      setError(err.message || 'Errore caricamento controparti');
    } finally {
      setLoading(false);
    }
  }, [page, rowsPerPage, sortKey, sortOrder, filterData]);

  useEffect(() => {
    fetchData();
  }, [fetchData]);

  const toggleSort = (key) => {
    if (key === sortKey) {
      setSortOrder((prev) => (prev === 'asc' ? 'desc' : 'asc'));
    } else {
      setSortKey(key);
      setSortOrder('asc');
    }
    setPage(0);
  };

  const toggleSearchPanel = () => setShowSearch(prev=>!prev);

  const handleAdd = () => {
    setSelectedItem({ tipo: 'CLIENTE', nazione: 'Italia' });
    setMessage('');
  };

  const handleEdit = () => {
    if (selectedIds.length !== 1) {
      alert('Seleziona una sola riga da modificare');
      return;
    }
    const item = list.find(r=>r.id===selectedIds[0]);
    setSelectedItem(item);
  };

  const handleDelete = () => {
    if(selectedIds.length===0){alert('Seleziona almeno una riga');return;}
    setShowDeleteDialog(true);
  };

  const performDelete = async () => {
    setShowDeleteDialog(false);
    setLoading(true);
    try {
      await Promise.all(selectedIds.map(id=>counterpartiesApi.delete(id)));
      setMessage(`✅ Eliminati ${selectedIds.length} record`);
      setSelectedIds([]);
      fetchData();
    } catch(err){
      setError(err.message);
    } finally {setLoading(false);}
  };

  const handleSave = async () => {
    if(!selectedItem) return;
    setLoading(true);
    try {
      if(selectedItem.id){
        await counterpartiesApi.update(selectedItem.id, selectedItem);
        setMessage('✅ Aggiornamento completato');
      } else {
        await counterpartiesApi.insert(selectedItem);
        setMessage('✅ Inserimento completato');
      }
      setSelectedItem(null);
      fetchData();
    } catch(err){
      setError(err.message);
    } finally {setLoading(false);}
  };

  const handleHeadChange = (data) => {
    setSelectedItem(prev=>({...prev, ...data}));
  };

  const handleRowClick = (id) => {
    setSelectedIds(prev=>{
      const s=new Set(prev);
      s.has(id)?s.delete(id):s.add(id);
      return [...s];
    });
  };

  // debounced search
  const handleSearch = useCallback(async (filters)=>{
    setFilterData(filters);
  },[]);
  const handleSearchDebounced = useMemo(()=>debounce(handleSearch,500),[]);

  return (
    <div className="table-panel">
      {error && <div className="message-error">{error}</div>}
      {message && <div className="message-success">{message}</div>}

      <FilterSearch
        fields={filterFields}
        onApply={(data) => {
          setFilterData(data);
          setPage(0);
        }}
      />

      <Header
        title="Gestione Controparti"
        onAdd={handleAdd}
        onEdit={handleEdit}
        onDelete={handleDelete}
        selectedCount={selectedIds.length}
        showSearch={showSearch}
        toggleSearch={toggleSearchPanel}
      />

      <TableGrid
        title="Gestione Controparti"
        columns={columns}
        rows={list}
        loading={loading}
        sortKey={sortKey}
        sortOrder={sortOrder}
        onSort={toggleSort}
        onRowClick={handleRowClick}
        selectedIds={selectedIds}
      />

      <div className="pagination-bar">
        <Pagination
          currentPage={page + 1}
          totalPages={totalPages}
          onPageChange={(newPage) => setPage(newPage - 1)}
        />
        <label>
          Rows:&nbsp;
          <select
            value={rowsPerPage}
            onChange={(e) => {
              const size = parseInt(e.target.value, 10);
              setRowsPerPage(size);
              setPage(0);
            }}
          >
            {rowsPerPageOptions.map(opt => <option key={opt} value={opt}>{opt}</option>)}
          </select>
        </label>
      </div>

      {showSearch && (
        <DialogCustom
          isOpen={showSearch}
          onClose={toggleSearchPanel}
          title="Filtri di Ricerca"
          onSave={handleSearchDebounced}
          onCancel={toggleSearchPanel}
          fields={filterFields}
          initialValues={filterData}
        />
      )}

      {selectedItem && (
        <HeadDocument
          isOpen={!!selectedItem}
          onClose={() => setSelectedItem(null)}
          onSave={handleSave}
          onCancel={() => setSelectedItem(null)}
          config={headDocumentConfig}
          data={selectedItem}
          onChange={handleHeadChange}
        />
      )}

      {showDeleteDialog && (
        <DialogCustom
          isOpen={showDeleteDialog}
          onClose={() => setShowDeleteDialog(false)}
          onConfirm={performDelete}
          title="Conferma Eliminazione"
          message={`Sei sicuro di voler eliminare ${selectedIds.length} record? Questa azione è irreversibile.`}
        />
      )}
    </div>
  );
} 