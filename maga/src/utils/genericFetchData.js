//========================================================
//File: maga/src/utils/genericFetchData.js
//Script che definisce la funzione per fare fethc di dati da
//un endpoint generico
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-17"
//=========================================================

const genericFetchData = (apiFn, schema) => async ({
  filters, page, limit, sortColumn, sortDirection
}) => {
  console.log('genericFetchData chiamata', { filters, page, limit, sortColumn, sortDirection, schema });
  if (!schema || !schema.properties) {
    console.error('ERRORE: schema o schema.properties non definiti!', schema);
    return { data: [], totalRows: 0 };
  }
  const params = {};
  Object.keys(schema.properties).forEach(col => {
    params[`p_${col}`] = filters[col] || null;
  });
  params.p_page = page + 1;
  params.p_page_size = limit;
  params.p_order_by = sortColumn || 'id';
  params.p_order_dir = (sortDirection || 'desc').toUpperCase();

  console.log('Chiamo counterpartiesApi.get con:', params);

  // CHIAMATA API
  try {
    const res = await apiFn(params);
    console.log('Risposta API:', res);

    // Adatta qui:
    const data = res.rows || [];
    const totalRows = res.meta?.totalRows || 0;
    return { data, totalRows };
  } catch (err) {
    console.error('ERRORE in genericFetchData:', err);
    return { data: [], totalRows: 0 };
  }
};

export default genericFetchData;
