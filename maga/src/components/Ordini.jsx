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
import fornitoriApi from '../api/fornitoriApi'; // API per i fornitori
import Header from './Header';
import TableGrid from './TableGrid';
import HeadDocument from './HeadDocument2'; // Usiamo la versione più recente
import Pagination from './Pagination1';
import '../css/Ordini.css'; // Riusiamo lo stile per coerenza

const rowsPerPageOptions = [5, 10, 20, 50];

const Ordini = ({ currentUser, currentLocation, onLogout }) => {
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

  // Configurazione per il componente HeadDocument
  const headDocumentConfig = useMemo(() => ({
    titolo: "Dettaglio Testata Ordine",
    fields: [
      { name: 'num_ordine', label: 'Numero Ordine', type: 'text', required: true },
      { name: 'data_ordine', label: 'Data Ordine', type: 'date', required: true },
      { name: 'fornitore_id', label: 'Fornitore', type: 'select', api: fornitoriApi.fetchAll, optionLabel: 'rag_soc', required: true },
      { name: 'stato', label: 'Stato', type: 'select', options: ['Aperto', 'Chiuso', 'Annullato'], required: true },
      { name: 'note', label: 'Note', type: 'textarea' },
    ]
  }), []);

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
  }, []);

  const handleOrdineSelect = useCallback(async (ordineId) => {
    if (!ordineId) {
      setSelectedOrdine(null);
      setOrdineRighe([]);
      return;
    }

    setLoading(true);
    setError('');
    try {
      // Recupera sia la testata che le righe in parallelo
      const [testata, righe] = await Promise.all([
        ordiniApi.fetchById(ordineId),
        ordiniRigheApi.fetchByOrdineId(ordineId) // Nuovo metodo API
      ]);

      // --- INIZIO BLOCCO DI DEBUG ---
      const righeIds = new Set();
      const righeDuplicates = [];
      righe.forEach(item => {
        if (item.id === undefined || item.id === null) {
          console.warn(`Trovata riga ordine con ID mancante per l'ordine ${ordineId}:`, item);
        }
        if (righeIds.has(item.id)) {
          righeDuplicates.push(item.id);
        }
        righeIds.add(item.id);
      });
      if (righeDuplicates.length > 0) {
        console.error(`Trovati ID duplicati nelle righe dell'ordine ${ordineId}:`, righeDuplicates);
      }
      // --- FINE BLOCCO DI DEBUG ---
      
      // Formatta la data per il componente HeadDocument (che vuole YYYY-MM-DD)
      testata.data_ordine = new Date(testata.data_ordine).toISOString().split('T')[0];

      setSelectedOrdine(testata);
      setOrdineRighe(righe);
      setSelectedDetailIds([]); // Pulisce la selezione delle righe quando si cambia ordine
    } catch (err) {
      setError(`Errore nel caricamento dei dettagli dell'ordine: ${err.message}`);
      setSelectedOrdine(null);
      setOrdineRighe([]);
    } finally {
      setLoading(false);
    }
  }, []);

  const handleBackToMaster = () => {
    setSelectedOrdine(null);
    setOrdineRighe([]);
    setSelectedMasterIds([]); // Pulisce la selezione master
    setSelectedDetailIds([]); // Pulisce la selezione detail
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

  return (
    <>
      <Header
        onBack={selectedOrdine ? handleBackToMaster : null} // Mostra "Indietro" solo in vista dettaglio
        onAdd={!selectedOrdine ? handleNewOrdine : null} // Mostra "Aggiungi" solo nella vista master
        onSave={selectedOrdine ? handleSaveOrdine : null} // Mostra "Salva" solo nella vista dettaglio
        currentUser={currentUser}
        currentLocation={currentLocation}
        onLogout={onLogout}
      />
      <div className="container">
        <h1 className="title-gestione-ordini">Gestione Ordini</h1>
        {error && <div className="message-error">{error}</div>}
        {message && <div className="message-success">{message}</div>}

        {selectedOrdine ? (
          // --- VISTA DETAIL ---
          <>
            <HeadDocument
              config={headDocumentConfig}
              initialData={selectedOrdine}
              onChange={handleHeadChange}
              readOnly={false} // o basato sui permessi/stato ordine
              
            />
            
            <h2>Righe Ordine</h2>
            <div className="table-wrapper">
              <TableGrid
                columns={detailColumns}
                rows={ordineRighe}                
                selectedIds={selectedDetailIds}
                onRowSelectionChange={handleDetailSelectionChange}
                // Aggiungi props per selezione, modifica, eliminazione righe se necessario
              />
            </div>
          </>
        ) : (
          // --- VISTA MASTER ---
          <>
            
            <div className="table-wrapper">
              <TableGrid
                columns={masterColumns}
                rows={currentTableData}
                selectedIds={selectedMasterIds}
                loading={loading}
                onRowSelectionChange={handleMasterSelectionChange}
                onRowClick={(rowId) => handleOrdineSelect(rowId)} // Azione al click sulla riga
                sortKey={sortKey}
                sortOrder={sortOrder}
                onSort={toggleSort}
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
          </>
        )}
      </div>
    </>
  );
};

export default Ordini;