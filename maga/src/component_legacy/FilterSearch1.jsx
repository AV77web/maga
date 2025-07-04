//=====================================================
// Componente generico per la raccolta dei filtri di ricerca.
// Riceve la definizione dei campi di filtro e una funzione
// da chiamare per eseguire la ricerca.
// @author: "villari.andrea@libero.it"
// @version: "1.1.0 2025-06-16" // Aggiornata versione
//=====================================================

import React, { useState, useEffect } from "react";
import "../css/FilterSearch.css"; // Importa il file CSS

function FilterSearch({ fields, onSearch, idPrefix = "filter" }) { // Removed onResults prop
  const [filters, setFilters] = useState({
    idart: "",
    idcau: "",
    tipo: "",
    fromDate: "",
    toDate: "",
  });

  const [error, setError] = useState("");
  const [loading, setLoading] = useState(false);

  // Initialize filter state based on the provided fields
  useEffect(() => {
    const initialFilters = {};
    fields.forEach(field => {
      initialFilters[field.name] = field.initialValue || '';
    });
    setFilters(initialFilters);
  }, [fields]); // Re-initialize if fields definition changes

  const handleSearch = async () => {
    console.log('[FilterSearch] handleSearch chiamato. Filtri:', filters);
    setLoading(true);
    setError("");
    try {
      // Call the search function provided by the parent component
      // The parent is responsible for calling the correct API and handling the query/request logic
      await onSearch(filters); // Parent handles setting results
    } catch (err) {
      setError(err.message || "Errore nella ricerca.");
    } finally {
      setLoading(false); // Assicura che lo stato di loading venga resettato
    }
  };

  return (
    <div className="filter-search-container">
      <h3>Filtro Ricerca</h3>
      <div className="filter-search-fields-wrapper">
        {fields.map(field => (
          <div key={field.name} className="filter-search-field">
            {field.label && <label htmlFor={`${idPrefix}-${field.name}`}>{field.label}</label>}
            {field.type === 'select' ? (
              <select
                id={`${idPrefix}-${field.name}`}
                name={field.name}
                value={filters[field.name] || ''}
                onChange={(e) => setFilters({ ...filters, [field.name]: e.target.value })}
                disabled={loading || field.disabled}
                autoComplete={field.autoComplete || "off"} // Added autocomplete
              >
                <option key="default-option" value="">{field.placeholder || `Seleziona ${field.label || field.name}`}</option>
                {(field.options || []).map(option => (
                  <option key={option.value} value={option.value}>
                    {option.label}
                  </option>
                ))}
              </select>
            ) : (
              <input
                id={`${idPrefix}-${field.name}`}
                type={field.type || 'text'}
                name={field.name}
                placeholder={field.placeholder || field.label || field.name}
                value={filters[field.name] || ''}
                onChange={(e) => setFilters({ ...filters, [field.name]: e.target.value })}
                disabled={loading || field.disabled}
                autoComplete={field.autoComplete || "off"} // Added autocomplete
              />
            )}
          </div>
        ))}
        <div className="filter-search-button-wrapper">
          <button onClick={handleSearch} disabled={loading}>Cerca</button>
        </div>
      </div>

      {error && <p className="filter-search-error">{error}</p>}
    </div>
  );
}

export default FilterSearch;
