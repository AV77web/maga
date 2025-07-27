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
import "../css/Ordini.css";

const rowsPerPageOptions = [5, 10, 20, 50];

const masterColumns = [
  { key: "id", label: "ID Ordine", cellClassName: "text-center" },
  { key: "num_ordine", label: "Numero Ordine", cellClassName: "text-left" },
  { key: "data_ordine", label: "Data", cellClassName: "text-center" },
  { key: "rag_soc", label: "Fornitore/Cliente", cellClassName: "text-left" },
  { key: "stato", label: "Stato", cellClassName: "text-center" },
];

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

  // Hook per il recupero dati
  const { data, isLoading, error } = useOrdini({
    enabled: true,
    filters: {
      ...filters,
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

  const handleSort = useCallback((key) => {
    setSort((prevSort) => {
      if (key === prevSort.key) {
        return {
          ...prevSort,
          order: prevSort.order === "asc" ? "desc" : "asc",
        };
      }
      return { key, order: "asc" };
    });
    setPage(1);
  }, []);

  const handleFilterChange = (e) => {
    const { name, value } = e.target;
    setFilters((prev) => ({ ...prev, [name]: value }));
    setPage(1); // Reset pagina quando cambiano i filtri
  };

  if (isLoading) return <div className="loader">Caricamento ordini...</div>;
  if (error)
    return (
      <div className="error-message">
        Errore nel caricamento degli ordini: {error.message}
      </div>
    );

  return (
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
              columns={masterColumns}
              rows={ordini}
              sortKey={sort.key}
              sortOrder={sort.order}
              onSort={handleSort}
              selectedIds={selectedIds}
              onRowSelectionChange={onSelectionChange}
              onRowDoubleClick={onOrdineSelect}
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
  );
};

export default OrdiniList;
