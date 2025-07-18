//======================================================
// File: useOrdine.js
// Hook personalizzato per gestire il fetching e le
// operazioni CRUD su un singolo ordine.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import ordiniApi from '../api/ordiniApi';

/**
 * Hook per recuperare i dati di un singolo ordine.
 * @param {number|null} ordineId - L'ID dell'ordine da recuperare.
 * @returns {object} Lo stato della query.
 */
export const useOrdine = (ordineId) => {
  return useQuery({
    queryKey: ['ordine', ordineId],
    queryFn: () => ordiniApi.fetchById(ordineId),
    enabled: !!ordineId, // La query verrà eseguita solo se ordineId non è nullo
    staleTime: 5 * 60 * 1000, // 5 minuti
  });
};

/**
 * Hook per le operazioni di mutazione (create, update, delete) su un ordine.
 * @returns {object} Un oggetto contenente le funzioni di mutazione.
 */
export const useOrdineMutations = () => {
  const queryClient = useQueryClient();

  // Mutazione per creare un nuovo ordine
  const createOrdine = useMutation({
    mutationFn: (newOrdine) => ordiniApi.insert(newOrdine),
    onSuccess: () => {
      // Invalida la cache della lista ordini per forzare un refresh
      queryClient.invalidateQueries({ queryKey: ['ordini'] });
    },
  });

  // Mutazione per aggiornare un ordine esistente
  const updateOrdine = useMutation({
    mutationFn: ({ id, ...data }) => ordiniApi.update(id, data),
    onSuccess: (data, variables) => {
      // Aggiorna la cache del singolo ordine e della lista
      queryClient.invalidateQueries({ queryKey: ['ordine', variables.id] });
      queryClient.invalidateQueries({ queryKey: ['ordini'] });
    },
  });

  // Mutazione per eliminare un ordine
  const deleteOrdine = useMutation({
    mutationFn: (id) => ordiniApi.delete(id),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['ordini'] });
    },
  });

  return {
    createOrdine: createOrdine.mutateAsync,
    updateOrdine: updateOrdine.mutateAsync,
    deleteOrdine: deleteOrdine.mutateAsync,
    isLoading: createOrdine.isPending || updateOrdine.isPending || deleteOrdine.isPending,
    error: createOrdine.error || updateOrdine.error || deleteOrdine.error,
  };
}; 