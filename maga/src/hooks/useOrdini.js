//======================================================
// File: useOrdini.js
// Hook personalizzato per gestire il fetching e la
// gestione dello stato degli ordini utilizzando React Query.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import { useQuery } from "@tanstack/react-query";
import ordiniApi from "../api/ordiniApi";

/**
 * Hook per recuperare l'elenco degli ordini con gestione dello stato, cache, e filtri.
 *
 * @param {object} options - Le opzioni per la query.
 * @param {boolean} options.enabled - Se la query deve essere eseguita automaticamente.
 * @param {object} options.filters - I filtri da applicare alla query.
 * @param {number} options.filters.page - Il numero di pagina.
 * @param {number} options.filters.pageSize - Il numero di elementi per pagina.
 * @param {string} options.filters.orderBy - Il campo per l'ordinamento.
 * @param {string} options.filters.orderDir - La direzione dell'ordinamento.
 * @param {string} options.filters.num_ordine - Il numero dell'ordine da filtrare.
 * @param {string} options.filters.data_da - La data di inizio per il filtro.
 * @param {string} options.filters.data_a - La data di fine per il filtro.
 */
export const useOrdini = ({ enabled = true, filters = {} } = {}) => {
  const {
    page = 1,
    pageSize = 10,
    orderBy = "id_ordine",
    orderDir = "DESC",
    num_ordine,
    data_da,
    data_a,
  } = filters;

  const queryKey = [
    "ordini",
    { page, pageSize, orderBy, orderDir, num_ordine, data_da, data_a },
  ];

  const queryFn = () => {
    const params = new URLSearchParams({
      page,
      pageSize,
      orderBy,
      orderDir,
    });
    if (num_ordine) params.append("num_ordine", num_ordine);
    if (data_da) params.append("data_da", data_da);
    if (data_a) params.append("data_a", data_a);

    return ordiniApi.fetchAll(params);
  };

  return useQuery({
    queryKey,
    queryFn,
    enabled,
    staleTime: 5 * 60 * 1000, // 5 minuti
    cacheTime: 10 * 60 * 1000, // 10 minuti
  });
};
