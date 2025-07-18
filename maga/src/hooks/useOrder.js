// ===============================================
// Hook: useOrder.js
// Gestisce fetch, cache e salvataggi di un ordine
// (testata + righe) tramite TanStack React Query.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-18"
// ===============================================

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query';
import ordiniApi from '../api/ordiniApi';
import ordiniRigheApi from '../api/ordiniRigheApi';

/**
 * @param {number|null} orderId - ID dell'ordine; null per un nuovo ordine
 */
export default function useOrder(orderId) {
  const qc = useQueryClient();

  /* ---------- FETCH HEAD ---------- */
  const orderHead = useQuery({
    queryKey: ['order', orderId],
    queryFn: () => ordiniApi.fetchById(orderId),     // NB: endpoint da creare se assente
    enabled: !!orderId,                              // skip se è un nuovo ordine
    staleTime: 60_000,                               // 1 min
  });

  /* ---------- FETCH LINES ---------- */
  const orderLines = useQuery({
    queryKey: ['orderLines', orderId],
    queryFn: () =>
      ordiniRigheApi
        .fetchByOrdineId(orderId)
        .then((res) => (Array.isArray(res) ? res : res?.rows || [])),
    enabled: !!orderId,
    staleTime: 60_000,
  });

  /* ---------- SAVE HEAD (insert / update) ---------- */
  const saveHead = useMutation({
    mutationFn: (data) =>
      orderId ? ordiniApi.update(orderId, data) : ordiniApi.insert(data),
    onSuccess: (/* res */) => {
      qc.invalidateQueries(['orders']);              // ricarica lista
      qc.invalidateQueries(['order', orderId]);      // ricarica dettaglio
    },
  });

  /* ---------- SAVE LINES (batch PATCH) ---------- */
  const saveLines = useMutation({
    mutationFn: (payload) =>
      ordiniRigheApi._request(
        'patch',
        `/api/ordini/${orderId}/righe`,
        payload
      ),
    onSuccess: () => qc.invalidateQueries(['orderLines', orderId]),
  });

  return {
    orderHead,
    orderLines,
    saveHead,
    saveLines,
  };
} 