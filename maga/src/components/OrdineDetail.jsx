//======================================================
// File: OrdineDetail.jsx
// Componente per visualizzare i dettagli di un singolo ordine.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import React, { useState, useMemo } from 'react';
import { useOrdine } from '../hooks/useOrdine';
import { useOrdineRighe, useOrdineRigheMutations } from '../hooks/useOrdineRighe';
import DocumentHeaderForm from './DocumentHeaderForm';
import TableGrid from './TableGrid';
import OrdineRigaDialog from './OrdineRigaDialog';
import orderSchema from '#schemas/order.schema.json';
import { orderUiHints } from '../uiHints/orderUiHints';

const detailColumns = [
    { key: 'id', label: 'ID Riga', cellClassName: 'text-center' },
    { key: 'id_articolo', label: 'ID Articolo', cellClassName: 'text-center' },
    { key: 'nome_articolo', label: 'Nome Articolo', cellClassName: 'text-left' },
    { key: 'quantita', label: 'Quantità', cellClassName: 'text-right' },
    { key: 'prezzo_unitario', label: 'Prezzo', cellClassName: 'text-right' },
];

const OrdineDetail = ({ ordineId, onBack, onEdit }) => {
    console.log("OrdineDetail", ordineId);
    const [selectedDetailIds, setSelectedDetailIds] = useState([]);
    const [isRigaDialogOpen, setIsRigaDialogOpen] = useState(false);
    const [editingRiga, setEditingRiga] = useState(null);

    // Fetch dei dati
    const { data: ordineData, isLoading: isLoadingOrdine, error: errorOrdine } = useOrdine(ordineId);
    console.log("OrdineDetail: ordineId ricevuto:", ordineId);
    const { data: righeData, isLoading: isLoadingRighe, error: errorRighe } = useOrdineRighe(ordineId);

    const { createRiga, updateRiga, deleteRiga, isLoading: isMutating } = useOrdineRigheMutations(ordineId);

    const testata = useMemo(() => {
        if (!ordineData) return null;
        // Normalizzazione dati per il form
        let dataISO = ordineData.data_ordine;
        if (typeof dataISO === 'string' && !dataISO.match(/^\d{4}-\d{2}-\d{2}$/)) {
            dataISO = new Date(dataISO).toISOString().split('T')[0];
        }
        return { ...ordineData, data_ordine: dataISO };
    }, [ordineData]);

    const righe = useMemo(() => righeData?.rows || [], [righeData]);

    // Handlers per le azioni sulle righe
    const handleNuovaRiga = () => {
        setEditingRiga({ id_ordine: ordineId }); // Pre-imposta l'id dell'ordine
        setIsRigaDialogOpen(true);
    };

    const handleModificaRiga = () => {
        if (selectedDetailIds.length !== 1) return;
        const rigaToEdit = righe.find(r => r.id === selectedDetailIds[0]);
        setEditingRiga(rigaToEdit);
        setIsRigaDialogOpen(true);
    };

    const handleEliminaRiga = async () => {
        if (selectedDetailIds.length === 0) return;
        if (window.confirm(`Sei sicuro di voler eliminare ${selectedDetailIds.length} riga/e?`)) {
            try {
                await Promise.all(selectedDetailIds.map(id => deleteRiga(id)));
                setSelectedDetailIds([]);
            } catch (err) {
                alert(`Errore durante l'eliminazione: ${err.message}`);
            }
        }
    };

    const handleSalvaRiga = async (rigaData) => {
        try {
            if (rigaData.id) {
                await updateRiga(rigaData);
            } else {
                await createRiga(rigaData);
            }
            setIsRigaDialogOpen(false);
            setEditingRiga(null);
        } catch (err) {
            alert(`Errore nel salvataggio della riga: ${err.message}`);
        }
    };

    const isLoading = isLoadingOrdine || isLoadingRighe || isMutating;
    const error = errorOrdine || errorRighe;

    if (isLoading) return <div className="loader">Caricamento dettagli ordine...</div>;
    if (error) return <div className="error-message">Errore: {error.message}</div>;
    if (!testata) return <div>Ordine non trovato.</div>;

    return (
        <div className="detail-view">
            <DocumentHeaderForm
                schema={orderSchema}
                uiHints={orderUiHints}
                initialData={testata}
                isReadOnly={true}
            />
            <div className="detail-actions">
                <button onClick={handleNuovaRiga} className="btn-action">Aggiungi Riga</button>
                <button onClick={handleModificaRiga} disabled={selectedDetailIds.length !== 1} className="btn-action">Modifica Riga</button>
                <button onClick={handleEliminaRiga} disabled={selectedDetailIds.length === 0} className="btn-action btn-danger">Elimina Riga</button>
                <button onClick={onEdit} className="btn-action">Modifica Testata</button>
            </div>
            <TableGrid
                columns={detailColumns}
                rows={righe}
                selectedIds={selectedDetailIds}
                onRowSelect={(id, checked) => setSelectedDetailIds(prev => checked ? [...prev, id] : prev.filter(i => i !== id))}
            />
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

export default OrdineDetail; 