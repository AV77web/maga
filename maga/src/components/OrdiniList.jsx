//======================================================
// File: OrdiniList.jsx
// Componente per visualizzare la lista master degli ordini.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import React, { useState, useMemo, useCallback } from "react";
import { useOrdini } from "../hooks/useOrdini";
import TableGrid from "./TableGrid";
import Pagination from "./Pagination1";
import Header from "./Header";
import "../css/Ordini.css";

const rowsPerPageOptions = [5, 10, 20, 50];

const masterColumns = [
  { key: "id", label: "ID Ordine", cellClassName: "text-center" },
  { key: "num_ordine", label: "Numero Ordine", cellClassName: "text-left" },
  { key: "data_ordine", label: "Data", cellClassName: "text-center" },
  { key: "rag_soc", label: "Fornitore/Cliente", cellClassName: "text-left" },
  { 
    key: "stato",
    label: "Stato",
    cellClassName: (row) => {
      let classes = "text-center";
      if (row.stato === "APERTO") {
        classes += " stato-aperto";
      } else if (row.stato === "CHIUSO") {
        classes += " stato-chiuso";
      } else if (row.stato === "INVIATO") {
        classes += " stato-inviato";
      } else if (row.stato === "ANNULLATO") {
        classes += " stato-annullato";
      }
      return classes;
    },
  },
  { key: "magazzino_origine", label: "Magazzino Origine", cellClassName: "text-left" },
  { key: "magazzino_destinazione", label: "Magazzino Destinazione", cellClassName: "text-left" },
  { key: "data_consegna_prevista", label: "Data Consegna Prevista", cellClassName: "text-center" },
  { key: "priorita", label: "Priorità", cellClassName: "text-center"},
  { key: "vettore", label: "Vettore", cellClsassName: "text-left"},
  { key: "tipo_trasprto", label:"Tipo Trasporto", cellClassName: "text-left"},
  { key: "valuta", label: "Valuta", cellClassName: "text-left"},
  { key: "listino", label: "Listino", cellClassName: "text-left"},
  { key: "sconto_totale", label: "Sconto", cellClassName: "text-left"},
  { key: "condizioni_pagamento", label: "Condizioni Pagamento", cellClassName: "text-left"},
  { key: "aliquota_iva", label: "IVA", cellClassName: "text-left"},
  { key: "docuemetno_collegao", label: "Documento  collegato", cellClassName: "text-left"},
  { key: "utente_creazione" , label: "Utente Creazione", cellClassName: "text-lefts"}
];

// Mappatura delle chiavi delle colonne ai valori accettati dalla stored procedure
const columnKeyMapping = {
  "id": "id_ordine",
  "num_ordine": "num_ordine", 
  "data_ordine": "data_ordine",
  "rag_soc": "idanagrafica", // rag_soc corrisponde al campo idanagrafica nella SP
  "stato": "stato",
  "magazzino_origine": "id_ordine", // Fallback a id_ordine per colonne non ordinabili
  "magazzino_destinazione": "id_ordine", // Fallback a id_ordine per colonne non ordinabili
};

console.log(masterColumns);

const OrdiniList = ({ onOrdineSelect, selectedIds, onSelectionChange }) => {
  // Stati per filtri e paginazione
  const [filters, setFilters] = useState({
    num_ordine: "",
    data_da: "",
    data_a: "",
  });
  const [page, setPage] = useState(1);
  const [pageSize, setPageSize] = useState(10);
  const [sort, setSort] = useState({ key: "id_ordine", order: "desc" });
  
  // Stati per la ricerca nelle colonne
  const [activeSearchFields, setActiveSearchFields] = useState([]);
  const [searchValues, setSearchValues] = useState({});
  
  // Stato per la gestione delle colonne visibili
  const [visibleColumns, setVisibleColumns] = useState(() => {
    // Carica le preferenze dal localStorage
    const saved = localStorage.getItem('ordiniList_visibleColumns');
    if (saved) {
      try {
        return JSON.parse(saved);
      } catch (e) {
        console.warn('Errore nel parsing delle colonne salvate:', e);
      }
    }
    // Valori di default se non ci sono preferenze salvate
    return ["id", "num_ordine", "data_ordine", "rag_soc", "stato", "magazzino_origine", "magazzino_destinazione", "data_consegna_prevista", "priorita", "vettore", "tipo_trasprto", "valuta", "listino", "sconto_totale", "condizioni_pagamento", "aliquota_iva", "docuemetno_collegao", "utente_creazione"];
  });

  // Hook per il recupero dati
  const { data, isLoading, error } = useOrdini({
    enabled: true,
    filters: {
      ...filters,
      ...searchValues, // Aggiungi i valori di ricerca ai filtri
      page,
      pageSize,
      orderBy: sort.key,
      orderDir: sort.order,
    },
  });

  const ordini = useMemo(() => {
    if (!data || !data.data) return [];
    return data.data.map((o) => ({
      id: Number(o.id_ordine),
      num_ordine: String(o.num_ordine || "").trim(),
      data_ordine: new Date(o.data_ordine).toLocaleDateString("it-IT"),
      rag_soc: o.rag_soc || "",
      stato: String(o.stato || "").trim(),
      note: o.note || "",
    }));
  }, [data]);

  const totalCount = data?.totalRows || 0;
  const totalPages = Math.ceil(totalCount / pageSize);

  // Filtra le colonne in base alla visibilità
  const tableColumns = useMemo(() => {
    return masterColumns.filter(col => visibleColumns.includes(col.key));
  }, [masterColumns, visibleColumns]);

  const handleSort = useCallback((key) => {
    // Mappa la chiave della colonna al valore accettato dalla stored procedure
    const mappedKey = columnKeyMapping[key] || "id_ordine";
    
    setSort((prevSort) => {
      if (mappedKey === prevSort.key) {
        return {
          ...prevSort,
          order: prevSort.order === "asc" ? "desc" : "asc",
        };
      }
      return { key: mappedKey, order: "asc" };
    });
    setPage(1);
  }, []);

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters((prev) => ({ ...prev, [name]: value }));
    setPage(1); // Reset pagina quando cambiano i filtri
  };

  // Gestione della ricerca nelle colonne
  const handleToggleSearchField = useCallback((fieldKey) => {
    setActiveSearchFields((prev) => {
      if (prev.includes(fieldKey)) {
        // Rimuovi il campo dalla ricerca
        const newFields = prev.filter(field => field !== fieldKey);
        setSearchValues((prevValues) => {
          const newValues = { ...prevValues };
          delete newValues[fieldKey];
          return newValues;
        });
        return newFields;
      } else {
        // Aggiungi il campo alla ricerca
        return [...prev, fieldKey];
      }
    });
  }, []);

  const handleSearchValueChange = useCallback((fieldKey, value) => {
    setSearchValues((prev) => ({
      ...prev,
      [fieldKey]: value
    }));
    setPage(1); // Reset pagina quando cambiano i filtri di ricerca
  }, []);

  // Gestore per il cambio di visibilità delle colonne
  const handleColumnVisibilityChange = useCallback((columnKey, isVisible) => {
    setVisibleColumns(prev => {
      const newColumns = isVisible 
        ? [...prev, columnKey]
        : prev.filter(key => key !== columnKey);
      
      // Salva le preferenze nel localStorage
      localStorage.setItem('ordiniList_visibleColumns', JSON.stringify(newColumns));
      
      return newColumns;
    });
  }, []);

  if (isLoading) return <div className="loader">Caricamento ordini...</div>;
  if (error)
    return (
      <div className="error-message">
        Errore nel caricamento degli ordini: {error.message}
      </div>
    );

  return (
    <>
      <Header
        onColumnVisibility={handleColumnVisibilityChange}
        columns={masterColumns}
        visibleColumns={visibleColumns}
      />
      <div className="container">
        <div className="filter-bar">
        <input
          type="text"
          name="num_ordine"
          placeholder="Filtra per numero..."
          value={filters.num_ordine}
          onChange={handleFilterChange}
        />
        <input
          type="date"
          name="data_da"
          value={filters.data_da}
          onChange={handleFilterChange}
        />
        <input
          type="date"
          name="data_a"
          value={filters.data_a}
          onChange={handleFilterChange}
        />
      </div>
      <div className="table-panel">
        <div className="table-wrapper">
          <div className="master-view">
            <TableGrid
              title="Gestione Ordini"
              columns={tableColumns}
              rows={ordini}
              sortKey={sort.key}
              sortOrder={sort.order}
              onSort={handleSort}
              selectedIds={selectedIds}
              onRowSelectionChange={onSelectionChange}
              onRowDoubleClick={onOrdineSelect}
              activeSearchFields={activeSearchFields}
              onToggleSearchField={handleToggleSearchField}
              searchValues={searchValues}
              onSearchValueChange={handleSearchValueChange}
            />
            <div className="pagination-bar">
              <Pagination
                page={page}
                totalPages={totalPages}
                onPageChange={setPage}
              />
              <label>
                Elementi per pagina:&nbsp;
                <select
                  value={pageSize}
                  onChange={(e) => {
                    setPageSize(parseInt(e.target.value, 10));
                    setPage(1);
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
    </>
  );
};

export default OrdiniList;
