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
import Header from './Header';
import TableGrid from './TableGrid';
import HeadDocument from './HeadDocument2'; // Usiamo la versione più recente
import Pagination from './Pagination1';
import '../css/ArticoliTable.css'; // Riusiamo lo stile per coerenza

const rowsPerPageOptions = [5, 10, 20];

const Ordini = ({ currentUser, currentLocation, onLogout }) => {
  // --- STATI ---
  const [ordiniList, setOrdiniList] = useState([]); // Lista di tutti gli ordini (master)
  const [selectedOrdine, setSelectedOrdine] = useState(null); // Dati della testata dell'ordine selezionato
  const [ordineRighe, setOrdineRighe] = useState([]); // Righe dell'ordine selezionato

  const [loading, setLoading] = useState(false);
  const [error, setError] = useState('');
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);

  // --- CONFIGURAZIONI ---
  // Colonne per la tabella master degli ordini
  const masterColumns = useMemo(() => [
    { key: 'id', label: 'ID Ordine', cellClassName: 'text-center' },
    { key: 'ordine_num', label: 'Numero Ordine', cellClassName: 'text-left' },
    { key: 'data_ordine', label: 'Data', cellClassName: 'text-center' },
    { key: 'nome_fornitore', label: 'Fornitore', cellClassName: 'text-left' }, // Assumendo che la SP fornisca questo campo
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
      { name: 'ordine_num', label: 'Numero Ordine', type: 'text', required: true },
      { name: 'data_ordine', label: 'Data Ordine', type: 'date', required: true },
      { name: 'id_fornitore', label: 'Fornitore', type: 'select', api: 'http://localhost:3001/api/fornitori', required: true }, // API ipotetica
      { name: 'stato', label: 'Stato', type: 'select', options: ['Aperto', 'Chiuso', 'Annullato'], required: true },
      { name: 'note', label: 'Note', type: 'textarea' },
    ]
  }), []);

  // --- FUNZIONI DI FETCH ---
  const fetchOrdiniList = useCallback(async () => {
    setLoading(true);
    setError('');
    try {
      const data = await ordiniApi.fetchAll();
      // Formattiamo la data per la visualizzazione
      const formattedData = data.map(o => ({
        ...o,
        data_ordine: new Date(o.data_ordine).toLocaleDateString('it-IT')
      }));
      setOrdiniList(formattedData);
    } catch (err) {
      setError(`Errore nel caricamento degli ordini: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, []);

  // Fetch iniziale della lista ordini
  useEffect(() => {
    fetchOrdiniList();
  }, [fetchOrdiniList]);

  // --- GESTORI EVENTI ---
  const handleNewOrdine = useCallback(() => {
    // Prepara un oggetto vuoto per la creazione di un nuovo ordine
    const newOrdineTemplate = {
      id: null, // L'ID sarà null per un nuovo record
      ordine_num: '',
      data_ordine: new Date().toISOString().split('T')[0], // Data di oggi come default
      id_fornitore: '',
      stato: 'Aperto', // Stato di default
      note: ''
    };
    setSelectedOrdine(newOrdineTemplate);
    setOrdineRighe([]); // Le righe sono ovviamente vuote
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
      
      // Formatta la data per il componente HeadDocument (che vuole YYYY-MM-DD)
      testata.data_ordine = new Date(testata.data_ordine).toISOString().split('T')[0];

      setSelectedOrdine(testata);
      setOrdineRighe(righe);
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
  };

  const handleSaveOrdine = useCallback(async () => {
    if (!selectedOrdine) {
      setError("Nessun ordine da salvare.");
      return;
    }

    // Aggiungi qui una validazione più robusta se necessario
    if (!selectedOrdine.ordine_num || !selectedOrdine.data_ordine || !selectedOrdine.id_fornitore || !selectedOrdine.stato) {
      setError("Compila tutti i campi obbligatori della testata (Numero, Data, Fornitore, Stato).");
      return;
    }

    setLoading(true);
    setError('');
    try {
      if (selectedOrdine.id) {
        // Modalità UPDATE
        await ordiniApi.update(selectedOrdine.id, selectedOrdine);
        setMessage('✅ Ordine aggiornato con successo!');
      } else {
        // Modalità CREATE
        const { id, ...dataToInsert } = selectedOrdine; // Rimuovi l'ID nullo
        await ordiniApi.insert(dataToInsert);
        setMessage('✅ Ordine creato con successo!');
      }
      // Dopo il salvataggio, ricarica la lista e torna alla vista master
      fetchOrdiniList();
      handleBackToMaster();
    } catch (err) {
      setError(`❌ Errore nel salvataggio dell'ordine: ${err.message}`);
    } finally {
      setLoading(false);
    }
  }, [selectedOrdine, fetchOrdiniList]);

  const handleHeadChange = (updatedHeadData) => {
    // Qui puoi gestire l'aggiornamento della testata in tempo reale o preparare i dati per un salvataggio
    console.log("Dati testata aggiornati:", updatedHeadData);
    setSelectedOrdine(prev => ({ ...prev, ...updatedHeadData }));
  };

  // --- DATI PER LA VISUALIZZAZIONE ---
  const paginatedOrdiniList = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return ordiniList.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, ordiniList]);

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
        <h1>Gestione Ordini</h1>
        {error && <div className="message-error">{error}</div>}

        {selectedOrdine ? (
          // --- VISTA DETAIL ---
          <div className="ordine-detail-view">
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
                loading={loading}
                // Aggiungi props per selezione, modifica, eliminazione righe se necessario
              />
            </div>
          </div>
        ) : (
          // --- VISTA MASTER ---
          <div className="ordine-master-view">
            <h2>Elenco Ordini</h2>
            <div className="table-wrapper">
              <TableGrid
                columns={masterColumns}
                rows={paginatedOrdiniList}
                loading={loading}
                onRowClick={(rowId) => handleOrdineSelect(rowId)} // Azione al click sulla riga
              />
            </div>
            <div className="pagination-bar">
              <Pagination
                currentPage={page + 1}
                totalCount={ordiniList.length}
                pageSize={rowsPerPage}
                onPageChange={(newPage) => setPage(newPage - 1)}
              />
            </div>
          </div>
        )}
      </div>
    </>
  );
};

export default Ordini;