//============================================================
//File: Ordini.jsx
//Componente che gestisce la visualizzazione e la modifica
//degli ordini, combinando una vista master (lista ordini)
//con una vista detail (testata e righe ordine).
//@author: "villari.andrea@libero.it"
//@version: "2.0.0 2025-07-19" // Refactored with Hooks and Composition
//============================================================

import React, { useState, useCallback } from 'react';
import Header from './Header';
import OrdiniList from './OrdiniList';
import OrdineDetail from './OrdineDetail';
import OrdineForm from './OrdineForm';
import '../css/Ordini.css';

// Definiamo le modalità di visualizzazione
const VIEW_MODES = {
  LIST: 'list',
  DETAIL: 'detail',
  EDIT_FORM: 'edit_form',
  NEW_FORM: 'new_form',
};

const Ordini = ({ currentUser, onLogout }) => {
  // Stato per gestire la vista corrente e l'ID dell'ordine selezionato
  const [viewMode, setViewMode] = useState(VIEW_MODES.LIST);
  const [selectedOrdineId, setSelectedOrdineId] = useState(null);
  const [selectedMasterIds, setSelectedMasterIds] = useState([]); // Stato per la selezione

  // --- HANDLER PER LA NAVIGAZIONE ---

  const handleMasterSelectionChange = useCallback((id, checked) => {
    setSelectedMasterIds((prev) =>
      checked ? [...prev, id] : prev.filter((selId) => selId !== id)
    );
  }, []);

  // Mostra il form per un nuovo ordine
  const handleShowNewForm = useCallback(() => {
    setSelectedOrdineId(null);
    setSelectedMasterIds([]);
    setViewMode(VIEW_MODES.NEW_FORM);
  }, []);

  // Mostra i dettagli di un ordine esistente
  const handleShowDetail = useCallback((ordineId) => {
    setSelectedOrdineId(ordineId);
    setSelectedMasterIds([]);
    setViewMode(VIEW_MODES.DETAIL);
  }, []);
  
  // Mostra i dettagli dell'ordine selezionato dalla lista
  const handleShowSelectedDetail = useCallback(() => {
    if (selectedMasterIds.length !== 1) {
      alert("Seleziona un singolo ordine da visualizzare.");
      return;
    }
    handleShowDetail(selectedMasterIds[0]);
  }, [selectedMasterIds, handleShowDetail]);

  // Mostra il form di modifica per l'ordine correntemente visualizzato
  const handleShowEditForm = useCallback(() => {
    setViewMode(VIEW_MODES.EDIT_FORM);
  }, []);

  // Gestisce il salvataggio (sia creazione che modifica) e torna alla lista
  const handleSaveSuccess = useCallback(() => {
    setSelectedOrdineId(null);
    setSelectedMasterIds([]);
    setViewMode(VIEW_MODES.LIST);
  }, []);

  // Torna alla vista precedente (lista o dettaglio)
  const handleBack = useCallback(() => {
    if (viewMode === VIEW_MODES.EDIT_FORM) {
      setViewMode(VIEW_MODES.DETAIL); // Da modifica torna al dettaglio
    } else {
      setSelectedOrdineId(null);
      setSelectedMasterIds([]);
      setViewMode(VIEW_MODES.LIST); // Da dettaglio o nuovo, torna alla lista
    }
  }, [viewMode]);

  // --- LOGICA DI RENDERIZZAZIONE ---

  const renderContent = () => {
    switch (viewMode) {
      case VIEW_MODES.NEW_FORM:
        return (
          <OrdineForm 
            onSaveSuccess={handleSaveSuccess}
            onCancel={handleBack}
          />
        );
      case VIEW_MODES.EDIT_FORM:
        return (
          <OrdineForm
            ordineId={selectedOrdineId}
            onSaveSuccess={handleSaveSuccess}
            onCancel={handleBack}
          />
        );
      case VIEW_MODES.DETAIL:
        return (
          <OrdineDetail
            ordineId={selectedOrdineId}
            onEdit={handleShowEditForm}
            onBack={handleBack}
          />
        );
      case VIEW_MODES.LIST:
      default:
        return (
          <OrdiniList
            onOrdineSelect={handleShowDetail}
            selectedIds={selectedMasterIds}
            onSelectionChange={handleMasterSelectionChange}
          />
        );
    }
  };

  const isViewActionEnabled = viewMode === VIEW_MODES.LIST && selectedMasterIds.length === 1;

  return (
    <div className="ordini-container">
      <Header
        currentUser={currentUser}
        onAdd={handleShowNewForm}
        onEdit={isViewActionEnabled ? handleShowSelectedDetail : (viewMode === VIEW_MODES.DETAIL ? handleShowEditForm : null)}
        onBack={viewMode !== VIEW_MODES.LIST ? handleBack : null}
        // L'icona "onEdit" ora serve sia per "Visualizza Dettaglio" che per "Modifica Testata"
        // a seconda del contesto. Potremmo voler usare un'icona più generica o diversa.
        editButtonIcon={viewMode === VIEW_MODES.LIST ? 'view' : 'edit'} // Esempio per cambiare icona
      />
      
      <div className="ordini-content">
        {renderContent()}
      </div>
    </div>
  );
};

export default Ordini;
