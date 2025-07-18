//======================================================
// File: useOrdini.js
// Hook personalizzato per gestire il fetching e la
// gestione dello stato degli ordini utilizzando React Query.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import { useQuery } from '@tanstack/react-query';
import ordiniApi from '../api/ordiniApi';

/**
 * Hook per recuperare una lista paginata e ordinata di ordini.
 * @param {object} options - Opzioni per la query.
 * @param {number} options.page - Il numero di pagina (1-based).
 * @param {number} options.pageSize - Il numero di righe per pagina.
 * @param {string} options.sortKey - La colonna su cui ordinare.
 * @param {string} options.sortOrder - La direzione dell'ordinamento ('asc' o 'desc').
 * @param {object} options.filters - Un oggetto con i filtri da applicare.
 * @returns {object} Lo stato della query restituito da React Query.
 */
export const useOrdini = ({ page, pageSize, sortKey, sortOrder, filters = {} }) => {
  const queryKey = ['ordini', { page, pageSize, sortKey, sortOrder, filters }];

  const queryFn = async () => {
    const queryParams = {
      page: page + 1, // L'API potrebbe essere 1-based
      page_size: pageSize,
      order_by: sortKey,
      order_dir: sortOrder,
      ...filters,
    };
    console.log('useOrdini: Sending params to API:',queryParams);
    const data = await ordiniApi.fetchAll(queryParams);
    console.log('useOrdini: Received data from API:', data);
    return data;
  };

  return useQuery({
    queryKey,
    queryFn,
    staleTime: 5 * 60 * 1000, // 5 minuti
    placeholderData: (previousData, previousQuery) => previousData,
  });
}; 