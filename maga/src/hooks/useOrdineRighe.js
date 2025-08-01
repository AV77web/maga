//======================================================
// File: useOrdineRighe.js
// Hook personalizzato per gestire il fetching e le
// operazioni CRUD sulle righe di un ordine.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-19"
//======================================================

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import ordiniRigheApi from '../api/ordiniRigheApi';

/**
 * Hook per recuperare le righe di un ordine specifico.
 * @param {number|null} ordineId - L'ID dell'ordine di cui recuperare le righe.
 * @returns {object} Lo stato della query.
 */
export const useOrdineRighe = (ordineId) => {
  const enabled = !!ordineId;
  
  return useQuery({
    queryKey: ['ordineRighe', ordineId],
    queryFn: async () => {
    const data = await ordiniRigheApi.fetchByOrdineId(ordineId);
    console.log('Valore fetchByOrdineId in useQuery:', data); // <-- LOG QUI
    return data;
    },
    enabled,
    staleTime: 5 * 60 * 1000,
    
  });
 
  // return useQuery({
 // queryKey: ['ordineRighe', ordineId],
 //queryFn: () => ordiniRigheApi.fetchByOrdineId(ordineId),
 //enabled,
 //staleTime: 5 * 60 * 1000,
 //});
 
 // queryFn: async () => {
 // const data = await ordiniRigheApi.fetchByOrdineId(ordineId);
 // console.log('Valore fetchByOrdineId in useQuery:', data); // <-- LOG QUI
 // return data;
 // },
  
};

//console.log("DEBUG useOrdineRighe:", JSON.stringify(useOrdineRighe, null, 2));
/**
 * Hook per le operazioni di mutazione (create, update, delete) sulle righe d'ordine.
 * @param {number|null} ordineId - L'ID dell'ordine a cui le righe appartengono,
 *                                 necessario per invalidare la cache corretta.
 * @returns {object} Un oggetto contenente le funzioni di mutazione.
 */
export const useOrdineRigheMutations = (ordineId) => {
  const queryClient = useQueryClient();

  const commonOptions = {
    onSuccess: () => {
      // Invalida la cache delle righe per l'ordine corrente per forzare un refresh
      queryClient.invalidateQueries({ queryKey: ['ordineRighe', ordineId] });
    },
  };

  // Mutazione per creare una nuova riga
  const createRiga = useMutation({
    mutationFn: (newRiga) => ordiniRigheApi.insert({ ...newRiga, id_ordine: ordineId }),
    ...commonOptions,
  });

  // Mutazione per aggiornare una riga esistente
  const updateRiga = useMutation({
    mutationFn: ({ id, ...data }) => ordiniRigheApi.update(id, data),
    ...commonOptions,
  });

  // Mutazione per eliminare una o più righe
  const deleteRiga = useMutation({
    // La mutationFn si aspetta un array di ID per gestire l'eliminazione multipla
    mutationFn: (rigaId) => ordiniRigheApi.delete(rigaId),
    ...commonOptions,
  });

  return {
    createRiga: createRiga.mutateAsync,
    updateRiga: updateRiga.mutateAsync,
    deleteRiga: deleteRiga.mutateAsync,
    isLoading: createRiga.isPending || updateRiga.isPending || deleteRiga.isPending,
    error: createRiga.error || updateRiga.error || deleteRiga.error,
  };
}; 