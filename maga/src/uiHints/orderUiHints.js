//==============================================
// File: orderUIHints.js
// UI Hints per la gestione della testata ordine
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-07-23"
//==============================================

export const orderUiHints = {
  num_ordine:   { label: 'Numero Ordine', order: 1 ,group: "Ordine"},
  data_ordine:  { label: 'Data',          order: 2, type: 'date' ,group: "Ordine"},
  stato:  { order: 3, type: 'select', enum: ['APERTO', 'INVIATO', 'CHIUSO', 'ANNULLATO'],group: "Ordine"},
  controparte_id: {
    label: 'Codice Fornitore/Cliente',
    order: 4,
    type: 'select',
    fetchOptions: async () => {
      const { default: counterpartiesApi } = await import('../api/counterpartiesApi.js');
      const res = await counterpartiesApi.fetchAll({ tipo: 'FORNITORE' });
      return res?.rows || res;
    },
    optionLabel: 'rag_soc',
    group: "Cliente/Fornitore"
  },
  rag_soc: { label: 'Ragione sociale', order: 5, readonly: true,group: "Cliente/Fornitore"},
  partita_iva: { label: 'Partita IVA', order: 6 , readonly: true,group: "Cliente/Fornitore"},
  indirizzo_fatturazione: { label: 'Indirizzo fatturazione', order: 7, readonly: true,group: "Cliente/Fornitore"},
  indirizzo_spedizione: { label: 'Indirizzo Spedizione', order: 8, readonly: true,group: "Cliente/Fornitore"},
  contatto: { label: 'Contatto', order: 9, readonly: true,group: "Cliente/Fornitore"},
  

  magazzino_origine: { label: "Magazzino di origine" , order: 10, group: "Trasporto"},
  magazzino_destinazione: { label: "Magazzino di destinazione",order: 11, group: "Trasporto"},
  data_consegna_prevista: { label: "Data consegna prevista", order: 12, type: 'date', group: "Trasporto"},
  priorita: { label: "Priorità", order: 13 ,type: 'select' , enum: ['Alta', 'Media', 'Bassa'], group: "Trasporto"},
  vettore: { label: "Vettore", order: 14, type: 'text', maxLength: 100, group: "Trasporto"},
  tipo_trasporto: { label: "Tipo di trasporto", order: 15, type: 'select', enum: ['Terrestre', 'Aereo', 'Marittimo'], group: "Trasporto"},
  
  valuta: { label: "Valuta", order: 16, type: 'select', enum: ['EUR', 'USD', 'GBP'], group: "Pagamento"},
  listino: { label: "Listino", order: 17, type: 'select', enum: ['Listino 1', 'Listino 2', 'Listino 3'], group: "Pagamento"},
  sconto_totale: { label: "Sconto totale", order: 18, type: 'number', min: 0, group: "Pagamento"},
  condizioni_pagamento: { label: "Condizioni di pagamento", order: 19, type: 'text', maxLength: 50, group: "Pagamento"},
  aliquota_iva: { label: "Aliquota IVA", order: 20, type: 'number', min: 0, group: "Pagamento"},
  documento_collegato: { label: "Documento collegato", order: 21, type: 'text', maxLength: 50, group: "Pagamento"},
  
  utente_creazione: { label: "Utente creazione", order: 22, type: 'text', maxLength: 50, group: "Utente"},
  causale: { label: "Causale", order: 23, type: 'text', maxLength: 100, group: "Utente"},
  created_at: { label: "Data creazione", order: 24, type: 'date', group: "Utente"},
  updated_at: { label: "Data ultima modifica", order: 25, type: 'date', group: "Utente"  },
  note:   { order: 99, type: 'textarea', group: "Utente"},  
}; 