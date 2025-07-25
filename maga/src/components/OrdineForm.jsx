//======================================================
// File: OrdineForm.jsx
// Componente per la creazione e modifica della testata di un ordine.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import React, { useState, useEffect } from 'react';
import { useOrdine, useOrdineMutations } from '../hooks/useOrdine';
import DocumentHeaderForm from './DocumentHeaderForm';
import orderSchema from '#schemas/order.schema.json';
import { orderUiHints } from '../uiHints/orderUiHints';

// Utility to normalize date fields and nulls
function normalizeFormData(data, dateFields = []) {
  const result = {};
  for (const key in data) {
    let value = data[key];
    if (dateFields.includes(key) && typeof value === 'string') {
      value = value.split('T')[0].split(' ')[0];
    }
    if (value === null || value === undefined) {
      value = '';
    }
    result[key] = value;
  }
  return result;
}

const newOrdineTemplate = {
  num_ordine: '',
  data_ordine: new Date().toISOString().split('T')[0],
  fornitore_id: '',
  stato: 'Aperto',
  note: ''
};

const OrdineForm = ({ ordineId, onSaveSuccess, onCancel }) => {
  // Se c'è un ordineId, siamo in modalità modifica, altrimenti creazione.
  const isEditing = !!ordineId;

  // Fetch dei dati solo se siamo in modalità modifica
  const { data: initialData, isLoading, error } = useOrdine(ordineId, {
    enabled: isEditing, // React Query hook option to enable/disable the query
  });

  const { updateOrdine, createOrdine, isLoading: isMutating } = useOrdineMutations();
  const [formData, setFormData] = useState(isEditing ? null : newOrdineTemplate);

  useEffect(() => {
    if (isEditing && initialData) {
      // Normalizza i dati per il form
      let dataISO = initialData.data_ordine;
      if (typeof dataISO === 'string' && !dataISO.match(/^\d{4}-\d{2}-\d{2}$/)) {
        dataISO = new Date(dataISO).toISOString().split('T')[0];
      }
      setFormData({ ...initialData, data_ordine: dataISO });
    }
  }, [initialData, isEditing]);

  const handleChange = (updatedData) => {
    setFormData(prev => ({ ...prev, ...updatedData }));
  };

  const handleSave = async () => {
    if (!formData.num_ordine || !formData.data_ordine || !formData.fornitore_id) {
        alert("Compila tutti i campi obbligatori (Numero, Data, Fornitore).");
        return;
    }
    
    try {
      if (isEditing) {
        await updateOrdine({ id: ordineId, ...formData });
      } else {
        await createOrdine(formData);
      }
      onSaveSuccess(); // Notifica il genitore del successo
    } catch (err) {
      alert(`Errore nel salvataggio: ${err.message}`);
    }
  };

  if (isLoading) return <div className="loader">Caricamento dati ordine...</div>;
  if (error) return <div className="error-message">Errore: {error.message}</div>;
  // Non renderizzare il form finché i dati per la modifica non sono caricati
  if (isEditing && !formData) return <div className="loader">In attesa dei dati...</div>;

  return (
    <DocumentHeaderForm
      schema={orderSchema}
      uiHints={orderUiHints}
      initialData={formData ? normalizeFormData(formData, [
        'data_ordine',
        'created_at',
        'updated_at',
        'data_consegna_prevista'
      ]) : formData}
      onChange={handleChange}
      onSave={handleSave}
      onCancel={onCancel}
      isSaving={isMutating}
    />
  );
};

export default OrdineForm; 