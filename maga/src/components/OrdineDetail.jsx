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
    { key: 'nome_articolo', label: 'Nome Articolo', cellClassName: 'text-left' },
    { key: 'quantita', label: 'Quantità', cellClassName: 'text-right' },
    { key: 'prezzo_unitario', label: 'Prezzo', cellClassName: 'text-right' },
    { key: 'totale_righe', label: 'Totale', cellClassName: 'text-right' }, // Nuovo campo dalla stored procedure
];

const OrdineDetail = ({ initialData, onBack, onEdit }) => {
    const ordineId = initialData?.id_ordine;
    
    // Controllo se ordineId è valido
    if (!ordineId) {
        return (
            <div className="error-message">
                Errore: ID ordine mancante o non valido. OrdineId ricevuto: {String(ordineId)}
            </div>
        );
    }
    
    const [selectedDetailIds, setSelectedDetailIds] = useState([]);
    const [isRigaDialogOpen, setIsRigaDialogOpen] = useState(false);
    const [editingRiga, setEditingRiga] = useState(null);

    // Fetch dei dati solo se initialData non è completo
    const { data: fetchedData, isLoading: isLoadingOrdine, error: errorOrdine } = useOrdine(ordineId, {
        enabled: !initialData || !initialData.rag_soc, // Carica solo se mancano i dati della controparte
    });
    
    const { createRiga, updateRiga, deleteRiga, isLoading: isMutating } = useOrdineRigheMutations(ordineId);

    const testata = useMemo(() => {
        const ordineData = initialData?.rag_soc ? initialData : fetchedData;
        if (!ordineData) return null;
        // Normalizzazione dati per il form
        let dataISO = ordineData.data_ordine;
        if (typeof dataISO === 'string' && !dataISO.match(/^\d{4}-\d{2}-\d{2}$/)) {
            dataISO = new Date(dataISO).toISOString().split('T')[0];
        }
        return { ...ordineData, data_ordine: dataISO };
    }, [initialData, fetchedData]);

    const righe = useMemo(() => {
        
        // Ora il backend restituisce direttamente le righe nel formato corretto
        const rawRighe = initialData?.righe || fetchedData?.result?.rows || fetchedData?.rows || [];
        
        // Trasforma i dati mappando id_riga a id per compatibilità con TableGrid
        const transformedRighe = rawRighe.map(riga => ({
            ...riga,
            id: riga.id_riga  // TableGrid richiede 'id' come campo chiave
        }));
        
        return transformedRighe;
    }, [initialData, fetchedData]);

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
                // Usa id_riga per l'eliminazione nel backend, ma selectedDetailIds contiene gli id trasformati
                await Promise.all(selectedDetailIds.map(id => {
                    const riga = righe.find(r => r.id === id);
                    return deleteRiga(riga.id_riga);
                }));
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

    const isLoading = (isLoadingOrdine && !initialData?.rag_soc) || isLoadingRighe || isMutating;
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
            
            {isLoadingRighe && <div className="loader">Caricamento righe ordine...</div>}
            {errorRighe && <div className="error-message">Errore caricamento righe: {errorRighe.message}</div>}
            
            <TableGrid
                columns={detailColumns}
                rows={righe}
                selectedIds={selectedDetailIds}
                onRowSelectionChange={(id, checked) => setSelectedDetailIds(prev => checked ? [...prev, id] : prev.filter(i => i !== id))}
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