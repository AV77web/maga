//==============================================
// File: orderUIHints.js
// UI Hints per la gestione della testata ordine
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-23"
//==============================================

export const orderUiHints = {
  num_ordine:   { label: 'Numero Ordine', order: 1 },
  data_ordine:  { label: 'Data',          order: 2, type: 'date' },
  fornitore_id: {
    label: 'Fornitore/Cliente',
    order: 3,
    type: 'select',
    fetchOptions: async () => {
      const { default: counterpartiesApi } = await import('../api/counterpartiesApi.js');
      const res = await counterpartiesApi.fetchAll({ tipo: 'FORNITORE' });
      return res?.rows || res;
    },
    optionLabel: 'rag_soc',
  },
  stato:  { order: 4 },
  note:   { order: 99, type: 'textarea' },
}; 