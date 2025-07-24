//==============================================
// File: orderUIHints.js
// UI Hints per la gestione della testata ordine
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-23"
//==============================================

export const orderUiHints = {
  num_ordine:   { label: 'Numero Ordine', order: 1 },
  data_ordine:  { label: 'Data',          order: 2, type: 'date' },
  controparte_id: {
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
  rag_soc: { label: 'Ragione socila', order: 4 , readonly: true},
  partita_iva: { label: 'Partita IVA', order: 5 , readonly: true},
  indirizzo_fatturazione: { label: 'Indirizzo fatturazione', ordrer: 6, readonly: true},
  indirizzo_spedizione: { label: 'Indirizzo Spedizione', order: 7, readonly: true},
  contatto: { label: 'Contatto', order: 8, readonly: true},
  stato:  { order: 9, type: 'select', enum: ['APERTO', 'INVIATO', 'CHIUSO', 'ANNULLATO']},
  magazzino_origine: { label: "Magazzino di origine" , order: 10},
  magazzino_destinazione: { label: "Magazzino di destinazione",order: 11},
  data_consegna_prevista: { label: "Data consegna prevista", order: 12, type: 'date'},
  priorita: { label: "Priorità", order: 13 ,type: 'select' , enum: ['Alta', 'Media', 'Bassa']},
  vettore: { label: "Vettore", order: 14, type: 'text', maxLength: 100},
  tipo_trasporto: { label: "Tipo di trasporto", order: 15, type: 'select', enum: ['Terrestre', 'Aereo', 'Marittimo']},
  valuta: { label: "Valuta", order: 16, type: 'select', enum: ['EUR', 'USD', 'GBP']},
  listino: { label: "Listino", order: 17, type: 'select', enum: ['Listino 1', 'Listino 2', 'Listino 3']},
  sconto_totale: { label: "Sconto totale", order: 18, type: 'number', min: 0},
  condizioni_pagamento: { label: "Condizioni di pagamento", order: 19, type: 'text', maxLength: 50},
  aliquota_iva: { label: "Aliquota IVA", order: 20, type: 'number', min: 0},
  documento_collegato: { label: "Documento collegato", order: 21, type: 'text', maxLength: 50},
  utente_creazione: { label: "Utente creazione", order: 22, type: 'text', maxLength: 50},
  causale: { label: "Causale", order: 23, type: 'text', maxLength: 100},
  created_at: { label: "Data creazione", order: 24, type: 'date'},
  updated_at: { label: "Data ultima modifica", order: 25, type: 'date'},
  note:   { order: 99, type: 'textarea' },  
}; 