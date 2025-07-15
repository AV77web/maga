export const orderUiHints = {
  num_ordine:   { label: 'Numero Ordine', order: 1 },
  data_ordine:  { label: 'Data',          order: 2, type: 'date' },
  fornitore_id: {
    label: 'Fornitore',
    order: 3,
    type: 'select',
    fetchOptions: async () => {
      const { default: fornitoriApi } = await import('../api/fornitoriApi.js');
      const res = await fornitoriApi.fetchAll();
      return res?.rows || res;
    },
    optionLabel: 'rag_soc',
  },
  stato:  { order: 4 },
  note:   { order: 99, type: 'textarea' },
}; 