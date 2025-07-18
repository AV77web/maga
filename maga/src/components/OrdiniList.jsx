//======================================================
// File: OrdiniList.jsx
// Componente per visualizzare la lista master degli ordini.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import React, { useState, useMemo, useCallback } from 'react';
import { useOrdini } from '../hooks/useOrdini';
import TableGrid from './TableGrid';
import Pagination from './Pagination1';
import '../css/Ordini.css';

const masterColumns = [
    { key: 'id', label: 'ID Ordine', cellClassName: 'text-center' },
    { key: 'num_ordine', label: 'Numero Ordine', cellClassName: 'text-left' },
    { key: 'data_ordine', label: 'Data', cellClassName: 'text-center' },
    { key: 'fornitore_id', label: 'Fornitore', cellClassName: 'text-left' },
    { key: 'stato', label: 'Stato', cellClassName: 'text-center' },
];

const OrdiniList = ({ onOrdineSelect, selectedIds, onSelectionChange }) => {
    const [page, setPage] = useState(0);
    const [pageSize, setPageSize] = useState(10);
    const [sortKey, setSortKey] = useState("num_ordine");
    const [sortOrder, setSortOrder] = useState("asc");

    const { data, isLoading, error } = useOrdini({
        page,
        pageSize,
        sortKey,
        sortOrder,
    });
    // DEBUG: stampa i dati ricevuti dall'API
    console.log('OrdiniList: Received data from useOrdini:', data);

    const ordini = useMemo(() => {
        // CORREZIONE DEFINITIVA: l'apiClientFactory "scarta" l'involucro 'result',
        // quindi i dati arrivano al componente come { rows: [...], meta: {...} }.
        if (!data || !data.rows) return [];
        const mapped = data.rows.map((o) => ({
            id: Number(o.id_ordine),
            num_ordine: String(o.num_ordine).trim(),
            data_ordine: new Date(o.data_ordine).toLocaleDateString('it-IT'),
            fornitore_id: Number(o.fornitore_id),
            stato: String(o.stato || '').trim(),
            note: o.note || '',
        }));
        return mapped;  
    }, [data]);

    // CORREZIONE DEFINITIVA: Il metadata si trova in data.meta
    const totalCount = data?.meta?.totalRows || 0;
    const totalPages = Math.ceil(totalCount / pageSize);

    // DEBUG: stampa i dati ricevuti dall'API
    console.log('OrdiniList: Pagination info :',{totalCount, totalPages, isLoading, error});

    const handleSort = useCallback((key) => {
        if (key === sortKey) {
            setSortOrder((prev) => (prev === "asc" ? "desc" : "asc"));
        } else {
            setSortKey(key);
            setSortOrder("asc");
        }
        setPage(0);
    }, [sortKey]);

    if (isLoading) return <div className="loader">Caricamento ordini...</div>;
    if (error) return <div className="error-message">Errore nel caricamento degli ordini: {error.message}</div>;

    return (
        <div className="master-view">
            <TableGrid
                columns={masterColumns}
                rows={ordini}
                sortKey={sortKey}
                sortOrder={sortOrder}
                onSort={handleSort}
                selectedIds={selectedIds}
                onRowSelectionChange={onSelectionChange} // Passa la funzione dal genitore
                onRowDoubleClick={onOrdineSelect}
            />
            <Pagination
                page={page}
                totalPages={totalPages}
                onPageChange={setPage}
            />
        </div>
    );
};

export default OrdiniList; 