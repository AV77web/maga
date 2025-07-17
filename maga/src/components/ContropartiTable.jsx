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
import DocumentHeaderForm from './DocumentHeaderForm';
import counterpartySchema from '#schemas/counterparty.schema.json';
import TableGrid from './TableGrid';
import Pagination from './Pagination1';
import FilterSearch from './FilterSearch';
import '../css/Ordini.css';
//import '../css/ArticoliTable.css'; // per stile uniforme
import debounce from 'lodash/debounce';

const rowsPerPageOptions = [5, 10, 20, 50];

export default function ContropartiTable() {
  const [list, setList] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);
  const [sortKey, setSortKey] = useState('rag_soc');
  const [sortOrder, setSortOrder] = useState('asc');
  const [totalPages, setTotalPages] = useState(1);
  const [totalCount, setTotalCount] = useState(0);
  const [filterData, setFilterData] = useState({});
  const [selectedItem, setSelectedItem] = useState(null);
  const [selectedIds, setSelectedIds] = useState([]);
  const [showDeleteDialog, setShowDeleteDialog] = useState(false);
  const [showSearch, setShowSearch] = useState(false);
  const [message, setMessage] = useState('');
  // Modalità corrente: "create", "edit" o "view" (per future estensioni)
  const [mode, setMode] = useState(null);

  const columns = useMemo(() => [
    { key: 'id', label: 'ID', cellClassName: 'text-center' },
    { key: 'rag_soc', label: 'Nome / Rag. Soc.', cellClassName: 'text-left' },
    { key: 'tipo', label: 'Tipo', cellClassName: 'text-center' },
    { key: 'citta', label: 'Città', cellClassName: 'text-left' },
    { key: 'telefono', label: 'Telefono', cellClassName: 'text-left' },
    { key: 'email', label: 'Email', cellClassName: 'text-left' },
  ], []);

  const filterFields = useMemo(() => [
    { name: 'rag_soc', label: 'Nome', type: 'text', placeholder: 'Cerca per nome...' },
    { name: 'tipo', label: 'Tipo', type: 'select', options: ['Privato', 'Azienda'], placeholder: '--Tipo--' },
    { name: 'citta', label: 'Città', type: 'text', placeholder: 'Cerca per città...' },
  ], []);

  const headDocumentConfig = useMemo(() => ({
    titolo: selectedItem?.id ? 'Modifica Controparte' : 'Nuova Controparte',
    fields: [
      { name: 'codice', label: 'Codice', type: 'text', required: true, maxLength: 10 },
      { name: 'rag_soc', label: 'Nome/Rag. Soc.', type: 'text', required: true, maxLength: 255 },
      { name: 'tipo', label: 'Tipo', type: 'select', options: ['Privato','Azienda'], required: true },
      { name: 'cf', label: 'Codice Fiscale', type: 'text', maxLength: 20, pattern: 'codiceFiscale' },
      { name: 'partita_iva', label: 'Partita IVA', type: 'text', maxLength: 20 },
      { name: 'indirizzo', label: 'Indirizzo', type: 'text', maxLength: 255 },
      { name: 'citta', label: 'Città', type: 'text', maxLength: 100 },
      { name: 'cap', label: 'CAP', type: 'text', maxLength: 5, pattern: 'cap' },
      { name: 'pv', label: 'PV', type: 'text', maxLength: 2 },
      { name: 'nazione', label: 'Nazione', type: 'text', maxLength: 50 },
      { name: 'telefono', label: 'Telefono', type: 'text', maxLength: 20 },
      { name: 'email', label: 'Email', type: 'email', maxLength: 100 },
      { name: 'contatto', label: 'Contatto', type: 'text', maxLength: 100 },
      { name: 'sito_web', label: 'Sito web', type: 'text', maxlength:100},
      { name: 'ruolo', label: 'Ruolo', type: 'select', options: ['cliente', 'fornitore', 'entrambi'], required: true },
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
      // Salviamo sempre l'intero dataset restituito dal backend
      setList(rows);
      // Calcola il totale delle righe e delle pagine da meta, con diversi fallback
      const totalRows =
        meta.totalRows ||
        meta.total_rows ||
        meta.total ||
        meta.totalCount ||
        rows.length;

      const calculatedPages = Math.max(1, Math.ceil(totalRows / rowsPerPage));


      setTotalCount(totalRows);
      setTotalPages(calculatedPages);

      // Nessun override: faremo slicing in fase di render
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

  const toggleSearchPanel = () => setShowSearch((prev)=>!prev);

  function validateCounterparty(data, isEdit = false) {
    // Campi sempre obbligatori per la creazione
    if (!isEdit) {
      const requiredFields = ['codice', 'rag_soc', 'partita_iva', 'cf', 'ruolo'];
      for (const field of requiredFields) {
        if (!data[field] || data[field].toString().trim() === '') {
          return `Il campo ${field} è obbligatorio.`;
        }
      }
    } else {
      // Per la modifica, solo i campi base sono obbligatori
      const requiredFields = ['codice', 'rag_soc'];
      for (const field of requiredFields) {
        if (!data[field] || data[field].toString().trim() === '') {
          return `Il campo ${field} è obbligatorio.`;
        }
      }
    }
    
    // In modifica, puoi aggiungere altri controlli se vuoi
    if (isEdit && !data.id) {
      return "ID mancante per la modifica.";
    }
    return null; // Nessun errore
  }



  const handleAdd = () => {
    setSelectedItem({ 
      codice: '',
      rag_soc: '',
      tipo: 'Privato', 
      cf: '',
      partita_iva: '',
      indirizzo: '',
      citta: '',
      cap: '',
      pv: '',
      nazione: 'Italia',
      telefono: '',
      email: '',
      contatto: '',
      sito_web: '',
      ruolo: 'cliente',
      note: ''
    });
    setMode('create');
    setMessage('');
  };

  const handleEdit = () => {
    if (selectedIds.length !== 1) {
      alert('Seleziona una sola riga da modificare');
      return;
    }
    const item = list.find(r=>r.id===selectedIds[0]);
    
    // Mappa i campi dal backend al frontend se necessario
    const mappedItem = {
      ...item,
      // Assicurati che i campi obbligatori siano presenti
      codice: item.codice || '',
      rag_soc: item.rag_soc || '',
      tipo: item.tipo || 'Privato',
      cf: item.cf || item.codice_fiscale || '',
      partita_iva: item.partita_iva || '',
      ruolo: item.ruolo || 'cliente',
      pv: item.pv || item.provincia || '',
      nazione: item.nazione || 'Italia'
    };
    
    setSelectedItem(mappedItem);
    setMode('edit');
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
    if (!selectedItem) return;
    console.log("DEBUG selectedItem", selectedItem);
    const isEdit = !!selectedItem.id;
    const validationError = validateCounterparty(selectedItem, isEdit);
    if (validationError) {
      setError(validationError);
      return;
    }

    setLoading(true);
    try {
      const allFields = {
        codice: selectedItem.codice || '',
        rag_soc: selectedItem.rag_soc || '',
        tipo: selectedItem.tipo || '',
        partita_iva: selectedItem.partita_iva || '',
        cf: selectedItem.cf || '',
        indirizzo: selectedItem.indirizzo || '',
        citta: selectedItem.citta || '',
        cap: selectedItem.cap || '',
        pv: selectedItem.pv || '',
        nazione: selectedItem.nazione || '',
        telefono: selectedItem.telefono || '',
        email: selectedItem.email || '',
        sito_web: selectedItem.sito_web || '',
        contatto: selectedItem.contatto || '',
        note: selectedItem.note || '',
        ruolo: selectedItem.ruolo || '',
        operation: isEdit ? 'update' : 'create'
      };
      // Normalizza sito_web
      if (allFields.sito_web && !allFields.sito_web.startsWith('http')) {
        allFields.sito_web = 'https://' + allFields.sito_web;
      }

      if(selectedItem.id){
        await counterpartiesApi.update(selectedItem.id, allFields);
        setMessage('✅ Aggiornamento completato');
      } else {
        await counterpartiesApi.insert(allFields);
        setMessage('✅ Inserimento completato');
      }
      setSelectedItem(null);
      setMode(null);
      fetchData();
    } catch(err){
      setError(err.message);
    } finally {setLoading(false);}
  };

  const handleHeadChange = (data) => {
    setSelectedItem(prev=>({...prev, ...data}));
  };

  const handleBack = () => {
    setSelectedItem(null);
    setMode(null);
    // Mantiene eventuale selezione o la resetta
    setSelectedIds([]);
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

  // log removed

  // Se il backend non tronca i risultati, effettuiamo il slicing qui
  const currentRows = useMemo(() => {
    if (list.length <= rowsPerPage) return list;
    return list.slice(page * rowsPerPage, (page + 1) * rowsPerPage);
  }, [list, page, rowsPerPage]);

  return (
    <>
      <Header
            
            onAdd={handleAdd}
            onEdit={handleEdit}
            onDelete={handleDelete}
            selectedCount={selectedIds.length}
            onSearch={toggleSearchPanel}
          />
      <div className="container">
        {error && <div className="message-error">{error}</div>}
        {message && <div className="message-success">{message}</div>}

        { !selectedItem && (
          <>
            {showSearch && (
              <FilterSearch
                fields={filterFields}
                onApply={(data) => {
                  setFilterData(data);
                  setPage(0);
                }}
              />
            )}

            <div className="table-wrapper">
              <div className="table-panel">
                <TableGrid
                  title="Gestione Controparti"
                  columns={columns}
                  rows={currentRows}
                  loading={loading}
                  sortKey={sortKey}
                  sortOrder={sortOrder}
                  onSort={toggleSort}
                  onRowClick={handleRowClick}
                  selectedIds={selectedIds}
                />
              </div>
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
                  }}
                >
                  {rowsPerPageOptions.map(opt => <option key={opt} value={opt}>{opt}</option>)}
                </select>
              </label>
            </div>
          </>
        )}

        { selectedItem && (
          <>
            <Header
              title={mode === 'create' ? 'Nuova Controparte' : (mode === 'edit' ? 'Modifica Controparte' : 'Dettaglio Controparte')}
              onBack={handleBack}
              onSave={handleSave}
            />

            <DocumentHeaderForm
              schema={counterpartySchema}
              initialData={selectedItem}
              onChange={handleHeadChange}
              readOnly={mode === 'view'}
            />
          </>
        )}

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

        {/* Dialog di eliminazione */}
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
    </>
  );
} 