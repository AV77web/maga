import React, { useEffect, useState } from "react";
import "../css/TubiPageCss.css";
import { BASE_URL } from '../config/config';
import TableView from './TableView';
import QuerySelect from './QuerySelect';
import TableExportButtons from './TableExportButtons';
import { Box } from '@mui/material';

const TABLE_NAME = 'cmr_tb_padtubi_MACC_TUBI';
const DEFAULT_QUERY_NAME = '__DEFAULT__';
const sortcol = "ID";
const sortdir = "desc";

const TubiPage = () => {
    const endpoint = `${BASE_URL}/query`;

    const [queries, setQueries] = useState([]);
    const [selectedQuery, setSelectedQuery] = useState(DEFAULT_QUERY_NAME);
    const [filteredQuery, setFilteredQuery] = useState('');
    const [columns, setColumns] = useState([]);
    const [activeFilters, setActiveFilters] = useState({});
    const [activeRangeFilters, setActiveRangeFilters] = useState({});
    const [initialFilters, setInitialFilters] = useState({});
    const [initialRangeFilters, setInitialRangeFilters] = useState({});

    const defaultQuery = `
    SELECT
      ID,
      dataora AS dataora_di_taglioTubo,
      macchina AS linea,
      ordine,
      TUBO_ID,
      LUNGHEZZA,
      PESO_TUBO,
      REPLACE(TRIM(articolo), ' ', '') AS articolo,
      velocita,
      REPLACE(TRIM(articolo_taglio), ' ', '') AS articolo_taglio,
      REPLACE(TRIM(articolo_netpro), ' ', '') AS articolo_netpro,
      stabilimento,
      GOOD,
      DEST_GOOD,
      DEST_3a,
      DEST_ottim,
      DEST_scarto,
      CASE
          WHEN ROW_NUMBER() OVER () = 1 THEN 0
          ELSE ABS(TIMESTAMPDIFF(SECOND, LAG(dataora) OVER (), dataora))
      END AS cadenza_s
    FROM ${TABLE_NAME}
    `;

    const selectedQueryObj = queries.find(q => q.query_text === selectedQuery);
    const queryName = selectedQueryObj?.query_name || 'Tutti i dati, no filtri';
    const queryTimestamp = selectedQueryObj?.created_at || new Date().toISOString();

    // 1️⃣ Caricamento query salvate
    useEffect(() => {
        fetch(`${BASE_URL}/savedqueries`)
            .then(res => res.json())
            .then(list => {
                setQueries(list);
                // // carica da storage dopo fetch
                // const lastKey = `tubiPageLastQuery_${localStorage.getItem('userName')}`;
                // const last = localStorage.getItem(lastKey);
                // if (last === DEFAULT_QUERY_NAME || list.some(q => q.query_text === last)) {
                //     setSelectedQuery(last || DEFAULT_QUERY_NAME);
                // }
            })
            .catch(console.error);
    }, []);

    // // 2️⃣ Carica filtri salvati localmente per la query selezionata
    // useEffect(() => {
    //     const key = `tubiPageState_${localStorage.getItem('userName')}_${selectedQuery}`;
    //     const saved = localStorage.getItem(key);
    //     if (saved) {
    //         try {
    //             const obj = JSON.parse(saved);
    //             setInitialFilters(obj.filters || {});
    //             setInitialRangeFilters(obj.rangeFilters || {});
    //         } catch {
    //             setInitialFilters({});
    //             setInitialRangeFilters({});
    //         }
    //     } else {
    //         setInitialFilters({});
    //         setInitialRangeFilters({});
    //     }
    // }, [selectedQuery]);

    // // 3️⃣ Salva in localStorage l'ultima query selezionata
    // useEffect(() => {
    //     const lastKey = `tubiPageLastQuery_${localStorage.getItem('userName')}`;
    //     localStorage.setItem(lastKey, selectedQuery);
    // }, [selectedQuery]);

    // // 4️⃣ Salva i filtri ogni volta che cambiano
    // useEffect(() => {
    //     const key = `tubiPageState_${localStorage.getItem('userName')}_${selectedQuery}`;
    //     localStorage.setItem(key, JSON.stringify({
    //         filters: activeFilters,
    //         rangeFilters: activeRangeFilters
    //     }));
    // }, [selectedQuery, activeFilters, activeRangeFilters]);

    const handleQueryChange = (event) => {
        setSelectedQuery(event.target.value);
        // setInitialFilters({});
        // setInitialRangeFilters({});
    };

    const handleTableState = (q, cols, filters, rangeFilters) => {
        setFilteredQuery(q);
        setColumns(cols);
        setActiveFilters(filters);
        setActiveRangeFilters(rangeFilters);
    };

    return (
        <>
            <br />
            <Box sx={{ flex: '1 1 auto', display: 'flex', flexDirection: 'column', minWidth: 400 }}>
                <div style={{ display: 'flex', alignItems: 'center' }}>
                    <QuerySelect
                        queries={queries}
                        selectedQuery={selectedQuery}
                        onQueryChange={handleQueryChange}
                        initialSortColumn={sortcol}
                        initialSortDirection={sortdir}
                        queryGroup="Produzione tubi"
                        label="Scegli tra le query salvate"
                    />
                    <TableExportButtons
                        endpoint={endpoint}
                        sql={filteredQuery}
                        columns={columns}
                        filename="tubi"
                        queryName={queryName}
                        queryTimestamp={queryTimestamp}
                        filters={activeFilters}
                        rangeFilters={activeRangeFilters}
                    />
                </div>
                <div>
                    <TableView
                        endpoint={endpoint}
                        query={selectedQuery === DEFAULT_QUERY_NAME ? defaultQuery : selectedQuery}
                        onStateChange={handleTableState}
                        initialFilters={initialFilters}
                        initialRangeFilters={initialRangeFilters}
                    />
                </div>
            </Box>
        </>
    );
};

export default TubiPage;