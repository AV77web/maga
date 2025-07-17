import React, { useEffect, useState, useMemo, useRef } from 'react';
import axios from 'axios';
import RangeFilterPopup from './RangeFilterPopup';
import './TableView.css';
import * as XLSX from 'xlsx';
import { saveAs } from 'file-saver';
import jsPDF from 'jspdf';
import autoTable from 'jspdf-autotable';

const CHAR_WIDTH = 8; // larghezza stimata per carattere (in px)

// Componente principale della tabella
const TableView = ({
    endpoint,
    query,
    initialSortColumn = '',
    initialSortDirection = 'desc',
    onStateChange,
    initialFilters = {},
    initialRangeFilters = {}
}) => {
    // Stato per i dati e configurazioni
    const [data, setData] = useState([]);
    const [columns, setColumns] = useState([]);
    const [filters, setFilters] = useState({});
    const [rangeFilters, setRangeFilters] = useState({});
    const [filterPopup, setFilterPopup] = useState({ open: false, col: null, center: null });
    const [sortColumn, setSortColumn] = useState(initialSortColumn);
    const [sortDirection, setSortDirection] = useState(initialSortDirection);
    const [page, setPage] = useState(0);
    const [limit, setLimit] = useState(20);
    const [totalCount, setTotalCount] = useState(0);
    const [inferredTypes, setInferredTypes] = useState({});

    // Ref per input filtri e scroll
    const filterInputRefs = useRef({});
    const tableContainerRef = useRef(null);
    const headerRef = useRef(null);
    const bodyRef = useRef(null);

    // --- LOGICA DI SALVATAGGIO/RIPRISTINO FILTRI IN MEMORIA LOCALE ---
    // useEffect(() => {
    //     // Carica filtri da localStorage per la query corrente
    //     const key = `tableViewState_${localStorage.getItem('userName')}_${query}`;
    //     const saved = localStorage.getItem(key);
    //     if (saved) {
    //         try {
    //             const obj = JSON.parse(saved);
    //             setFilters(obj.filters || {});
    //             setRangeFilters(obj.rangeFilters || {});
    //         } catch {
    //             setFilters({});
    //             setRangeFilters({});
    //         }
    //     } else {
    //         setFilters({});
    //         setRangeFilters({});
    //     }
    // }, [query]);
    // useEffect(() => {
    //     // Salva filtri su localStorage per la query corrente
    //     const key = `tableViewState_${localStorage.getItem('userName')}_${query}`;
    //     localStorage.setItem(key, JSON.stringify({
    //         filters,
    //         rangeFilters
    //     }));
    // }, [query, filters, rangeFilters]);
    // --- FINE LOGICA MEMORIA LOCALE ---

    // Imposta i filtri iniziali SOLO al primo mount (evita loop infiniti)
    useEffect(() => {
        setFilters(initialFilters);
        setRangeFilters(initialRangeFilters);
        // eslint-disable-next-line
    }, []); // Dipendenza vuota: solo al primo render

    // Fetch dei dati principali
    const fetchData = async () => {
        try {
            const sql = buildFilteredQuery();
            const response = await axios.get(endpoint, {
                params: { sql, limit, offset: page * limit, format: 'json', _t: Date.now() },
            });
            if (response.data.length > 0) {
                setColumns(Object.keys(response.data[0]));
            }
            setData(response.data);
        } catch (_) { }
    };

    // Fetch del conteggio totale dei risultati
    const fetchTotalCount = async () => {
        try {
            let baseQuery = buildFilteredQuery();
            const countQuery = `SELECT COUNT(*) AS count FROM (${baseQuery}) AS subquery`;
            const response = await axios.get(endpoint, {
                params: { sql: countQuery, format: 'json', _t: Date.now() },
            });
            if (response.data.length > 0) {
                setTotalCount(Number(response.data[0].count));
            } else {
                setTotalCount(0);
            }
        } catch (_) {
            setTotalCount(0);
        }
    };

    useEffect(() => {
        fetchData();
        fetchTotalCount();
    }, [
        page,
        limit,
        sortColumn,
        sortDirection,
        query,
        JSON.stringify(filters)
    ]);

    useEffect(() => {
        if (typeof onStateChange === 'function') {
            onStateChange(buildFilteredQuery(), columns, filters, rangeFilters);
        }
    }, [filters, rangeFilters, sortColumn, sortDirection, query, columns]);

    // Inferenza automatica dei tipi di colonna
    useEffect(() => {
        if (!data || data.length === 0 || columns.length === 0) return;

        const sampleSize = 50;
        const inferred = {};

        const isNumber = (val) => val !== null && val !== undefined && !isNaN(Number(val));
        const isDate = (val) => val !== null && val !== undefined && !isNaN(Date.parse(val));
        const isBoolean = (val) => {
            const v = String(val).toLowerCase();
            return ['0', '1', 'true', 'false'].includes(v);
        };
        const isArticolo = (val) => /^(\d+[.,]?\d*)x(\d+[.,]?\d*)x(\d+[.,]?\d*)\s*[sS][pP]?:?\s*(\d+[.,]?\d*)$/.test(String(val).trim());

        columns.forEach((col) => {
            const values = data.slice(0, sampleSize).map(row => row[col]).filter(Boolean);
            const total = values.length;

            let countBoolean = 0, countNumber = 0, countDate = 0, countArticolo = 0;
            for (const val of values) {
                if (isBoolean(val)) countBoolean++;
                if (isNumber(val)) countNumber++;
                if (isDate(val)) countDate++;
                if (isArticolo(val)) countArticolo++;
            }

            if (total === 0) inferred[col] = 'string';
            else if (countBoolean / total >= 0.95) inferred[col] = 'boolean';
            else if (countNumber / total >= 0.9) inferred[col] = 'number';
            else if (countDate / total >= 0.9) inferred[col] = 'date';
            else if (countArticolo / total >= 0.9) inferred[col] = 'articolo';
            else inferred[col] = 'string';
        });

        setInferredTypes(inferred);
    }, [data, columns]);

    // Conversione per compatibilità di visualizzazione
    const bitToInt = (val) => {
        if (typeof val === "number") return val;
        if (typeof val === "boolean") return val ? 1 : 0;
        if (typeof val === "string") {
            if (val.length === 1) return val.charCodeAt(0);
            if (val === "0" || val === "1") return Number(val);
        }
        return val;
    };

    const getColumnType = (col) => inferredTypes[col] || 'string';

    // Query SQL con condizioni da filtri
    const buildFilteredQuery = () => {
        let baseQuery = query;

        const filterConditions = Object.entries(filters)
            .filter(([_, value]) => value)
            .flatMap(([field, value]) => {
                const type = getColumnType(field);

                if ((type === 'date' || type === 'number') && typeof value === 'object') {
                    const conds = [];
                    if (value.from) conds.push(`${field} >= '${value.from}${type === 'date' && value.from.length === 10 ? ' 00:00:00' : ''}'`);
                    if (value.to) conds.push(`${field} <= '${value.to}${type === 'date' && value.to.length === 10 ? ' 23:59:59' : ''}'`);
                    return conds;
                }

                if (type === 'articolo' && Array.isArray(value)) {
                    const getPartExpr = (index) => {
                        switch (index) {
                            case 0: return `CAST(REPLACE(SUBSTRING_INDEX(${field}, 'x', 1), ',', '.') AS DECIMAL(10,2))`;
                            case 1: return `CAST(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(${field}, 'x', 2), 'x', -1), ',', '.') AS DECIMAL(10,2))`;
                            case 2: return `CAST(REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(${field}, 'x', -1), ' ', 1), ',', '.') AS DECIMAL(10,2))`;
                            case 3: return `CAST(REPLACE(LOWER(SUBSTRING_INDEX(${field}, ':', -1)), ',', '.') AS DECIMAL(10,2))`;
                            default: return null;
                        }
                    };
                    const conditions = [];
                    value.forEach((range, i) => {
                        if (range?.from) conditions.push(`${getPartExpr(i)} >= ${range.from}`);
                        if (range?.to) conditions.push(`${getPartExpr(i)} <= ${range.to}`);
                    });
                    return conditions;
                }

                return `${field} LIKE '%${value}%'`;
            });

        if (filterConditions.length > 0) {
            baseQuery += /where\s/i.test(baseQuery) ? ` AND ${filterConditions.join(' AND ')}` : ` WHERE ${filterConditions.join(' AND ')}`;
        }

        if (sortColumn) {
            baseQuery += ` ORDER BY ${sortColumn} ${sortDirection.toUpperCase()}`;
        }

        return baseQuery;
    };

    // Larghezza delle colonne in base al contenuto
    const columnWidths = useMemo(() => {
        const widths = {};
        columns.forEach((col) => {
            let maxLen = col.length;
            if (filters[col]) maxLen = Math.max(maxLen, filters[col].length);
            data.forEach(row => {
                const valStr = row[col] == null ? '' : String(row[col]);
                maxLen = Math.max(maxLen, valStr.length);
            });
            const maxChars = Math.min(maxLen, 40);
            widths[col] = maxChars * CHAR_WIDTH + 16;
        });
        return widths;
    }, [columns, data, filters]);

    // Gestione filtro singola colonna
    const handleFilterChange = (column, value) => {
        setFilters((prev) => ({ ...prev, [column]: value }));
        setPage(0);
    };

    const handleRangeFilterApply = (col, val) => {
        const isArticolo = Array.isArray(val);
        const empty = isArticolo ? val.every(r => !r.from && !r.to) : (val?.from === '' && val?.to === '');
        if (empty) {
            setRangeFilters(prev => { const p = { ...prev }; delete p[col]; return p; });
            setFilters(prev => { const p = { ...prev }; delete p[col]; return p; });
            setPage(0);
            return;
        }
        setRangeFilters(prev => ({ ...prev, [col]: val }));
        setFilters(prev => ({ ...prev, [col]: val }));
        setPage(0);
    };

    const handleSort = (column) => {
        if (sortColumn === column) {
            setSortDirection((prev) => (prev === 'asc' ? 'desc' : 'asc'));
        } else {
            setSortColumn(column);
            setSortDirection('asc');
        }
        setPage(0);
    };

    const onBodyScroll = () => {
        if (headerRef.current && bodyRef.current) {
            headerRef.current.scrollLeft = bodyRef.current.scrollLeft;
        }
    };

    const getTableCenter = () => {
        if (!tableContainerRef.current) return null;
        const rect = tableContainerRef.current.getBoundingClientRect();
        return { x: rect.width / 2, y: rect.height / 2 };
    };

    const totalWidth = Object.values(columnWidths).reduce((a, b) => a + b, 0);
    const totalPages = Math.ceil(totalCount / limit);

    const filteredQuery = buildFilteredQuery();

    return (

        <div className="table-view" ref={tableContainerRef} style={{ width: '100%', overflow: 'hidden', position: 'relative' }}>
            <div className="table-header-container" ref={headerRef} style={{ overflow: 'hidden', width: '100%', borderBottom: '1px solid #ccc' }}>
                <table className="table-header" style={{ width: totalWidth, borderCollapse: 'collapse', tableLayout: 'fixed' }}>
                    <thead>
                        <tr>
                            {columns.map((col) => (
                                <th key={col} onClick={() => handleSort(col)} style={{ width: columnWidths[col], minWidth: columnWidths[col], cursor: 'pointer', padding: '4px 8px' }}>
                                    {col} {sortColumn === col ? (sortDirection === 'asc' ? '🔼' : '🔽') : ''}
                                </th>
                            ))}
                        </tr>
                        <tr>
                            {columns.map((col) => {
                                const type = getColumnType(col);
                                return (
                                    <th key={`${col}-filter`} style={{ width: columnWidths[col], minWidth: columnWidths[col], padding: 0, position: 'relative' }}>
                                        {['date', 'number', 'articolo'].includes(type) ? (
                                            <input
                                                ref={el => { filterInputRefs.current[col] = el; }}
                                                type="text"
                                                placeholder="Filtro..."
                                                value={
                                                    type === 'articolo'
                                                        ? (
                                                            Array.isArray(rangeFilters[col]) && rangeFilters[col].some(r => r.from || r.to)
                                                                ? rangeFilters[col].map((r, i) =>
                                                                    (r.from || r.to)
                                                                        ? `${['L', 'A', 'Lun', 'Sp'][i]}:${r.from || ''}${r.to ? '→' + r.to : ''}`
                                                                        : ''
                                                                ).filter(Boolean).join(' | ')
                                                                : ''
                                                        )
                                                        : (
                                                            rangeFilters[col]
                                                                ? `${rangeFilters[col].from || ''}${rangeFilters[col].to ? ' → ' + rangeFilters[col].to : ''}`
                                                                : ''
                                                        )
                                                }
                                                readOnly
                                                onClick={() => setFilterPopup({ open: true, col, center: getTableCenter() })}
                                                style={{ width: '100%', padding: '4px 6px', border: 'none', background: '#f0f0f0', cursor: 'pointer' }}
                                            />
                                        ) : (
                                            <input
                                                type="text"
                                                placeholder="Filtro..."
                                                value={filters[col] || ''}
                                                onChange={e => handleFilterChange(col, e.target.value)}
                                                style={{ width: '100%', padding: '4px 6px', border: 'none' }}
                                            />
                                        )}
                                    </th>
                                );
                            })}
                        </tr>
                    </thead>
                    <RangeFilterPopup
                        open={filterPopup.open}
                        center={filterPopup.center}
                        type={getColumnType(filterPopup.col)}
                        value={rangeFilters[filterPopup.col]}
                        onClose={() => setFilterPopup({ open: false, col: null, center: null })}
                        onApply={val => handleRangeFilterApply(filterPopup.col, val)}
                    />
                </table>
            </div>

            <div className="table-body-container" ref={bodyRef} style={{ overflowX: 'auto', overflowY: 'auto', maxHeight: '660px', width: '100%' }} onScroll={onBodyScroll}>
                <table className="table-body" style={{ width: totalWidth, borderCollapse: 'collapse', tableLayout: 'fixed' }}>
                    <tbody>
                        {data.map((row, rowIndex) => (
                            <tr key={rowIndex} className={rowIndex % 2 === 0 ? 'even' : 'odd'}>
                                {columns.map((col) => (
                                    <td key={`${rowIndex}-${col}`} style={{ width: columnWidths[col], minWidth: columnWidths[col], padding: '4px 8px', whiteSpace: 'nowrap', overflow: 'hidden', textOverflow: 'ellipsis' }} title={String(row[col])}>
                                        {String(bitToInt(row[col]))}
                                    </td>
                                ))}
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>

            <div className="pagination">
                <button onClick={() => setPage(0)} disabled={page === 0}>Prima</button>
                <button onClick={() => setPage((p) => Math.max(p - 1, 0))} disabled={page === 0}>Indietro</button>
                <span>Pagina {page + 1} di {totalPages || 1}</span>
                <button onClick={() => setPage((p) => Math.min(p + 1, totalPages - 1))} disabled={page >= totalPages - 1}>Avanti</button>
                <button onClick={() => setPage(totalPages - 1)} disabled={page >= totalPages - 1}>Ultima</button>
                <select value={limit} onChange={(e) => setLimit(Number(e.target.value))}>
                    {[20, 50, 100, 250, 500, 1000].map((n) => (
                        <option key={n} value={n}>{n} righe per pagina</option>
                    ))}
                </select>
            </div>
        </div>
    );
};

export default TableView;