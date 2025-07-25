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

const rowsPerPageOptions = [5, 10, 20, 50];

const masterColumns = [
    { key: 'id', label: 'ID Ordine', cellClassName: 'text-center' },
    { key: 'num_ordine', label: 'Numero Ordine', cellClassName: 'text-left' },
    { key: 'data_ordine', label: 'Data', cellClassName: 'text-center' },
    { key: 'rag_soc', label: 'Fornitore/Cliente', cellClassName: 'text-left' },
    { key: 'stato', label: 'Stato', cellClassName: 'text-center' },
];

const OrdiniList = ({ onOrdineSelect, selectedIds, onSelectionChange }) => {
    const [page, setPage] = useState(0);
    const [pageSize, setPageSize] = useState(10);
    const [sortKey, setSortKey] = useState("num_ordine");
    const [sortOrder, setSortOrder] = useState("asc");

    const { data, isLoading, error } = useOrdini({
        page: page + 1,
        pageSize,
        sortKey,
        sortOrder,
    });
    // DEBUG: stampa i dati ricevuti dall'API
    //console.log('OrdiniList: Received data from useOrdini:', data);

    const ordini = useMemo(() => {
        // CORREZIONE DEFINITIVA: l'apiClientFactory "scarta" l'involucro 'result',
        // quindi i dati arrivano al componente come { rows: [...], meta: {...} }.
        if (!data || !data.rows) return [];
        const mapped = data.rows.map((o) => ({
            id: Number(o.id_ordine) || 0,
            num_ordine: String(o.num_ordine || '').trim(),
            data_ordine: new Date(o.data_ordine).toLocaleDateString('it-IT'),
            rag_soc: o.rag_soc || '', // Mostra la ragione sociale
            stato: String(o.stato || '').trim(),
            note: o.note || '',
        }));
        return mapped;  
    }, [data]);

    // CORREZIONE DEFINITIVA: Il metadata si trova in data.meta
    const totalCount = data?.meta?.totalRows || 0;
    const totalPages = Math.ceil(totalCount / pageSize);

    // DEBUG: stampa i dati ricevuti dall'API
    //console.log('OrdiniList: Pagination info :',{totalCount, totalPages, isLoading, error});

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
      // Parametri per paginazione e ordinamento lato server
      const queryParams = {
        page: page + 1, // la SP usa 1-based index
        page_size: pageSize,
        order_by: sortKey || "name",
        order_dir: sortOrder,
      };

    return (
        <div  className="container">
            <div className="table-panel">
                <div className="table-wrapper">
                <div className="master-view">
                    <TableGrid
                        title="Gestione Ordini"
                        columns={masterColumns}
                        rows={ordini}
                        sortKey={sortKey}
                        sortOrder={sortOrder}
                        onSort={handleSort}
                        selectedIds={selectedIds}
                        onRowSelectionChange={onSelectionChange} // Passa la funzione dal genitore
                        onRowDoubleClick={(id) => {
                            onOrdineSelect(id);
                        }}
                    />
                    <div className="pagination-bar">
                <Pagination
                    page={page + 1}
                    totalPages={totalPages}
                    onPageChange={(newPage) => setPage(newPage - 1)}
                />
                    <label>
                        Elementi per pagina:&nbsp;
                        <select
                            value={pageSize}
                            onChange={e => {
                            const newSize = parseInt(e.target.value, 10);
                               setPageSize(newSize);
                            setPage(0); // Reset to first page when page size changes
                            }}
                            disabled={isLoading}
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
            
             
                </div>
                </div>
            </div>
    
    );
};

export default OrdiniList; 