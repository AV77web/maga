//==========================================
//File: ordiniRigheApi.js
//Script che gestisce le chiamate http verso
//le api per le righe degli ordini.
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2025-07-19" // Refactored for correctness
//===========================================

import { createApiClient } from './apiClientFactory';

// createApiClient() fornisce già i metodi standard (insert, update, delete, etc.)
// che operano sull'endpoint 'orderlines' (/api/v1/orderlines).
const ordiniRigheApi = createApiClient('orderlines');

/**
 * Recupera le righe di un ordine specifico.
 * Questo è un metodo custom perché l'endpoint è nidificato sotto 'ordini'.
 * @param {string|number} ordineId - L'ID dell'ordine padre.
 * @returns {Promise<Array<object>>}
 */
ordiniRigheApi.fetchByOrdineId = (ordineId) => {
  // Validazione dell'ordineId
  if (!ordineId || ordineId === 'undefined' || ordineId === 'null') {
    return Promise.reject(new Error(`Invalid ordineId: ${ordineId}`));
  }
  
  // Assicura che la chiamata usi il path corretto e versionato dell'API.
  const customUrl = `http://localhost:3001/api/v1/orders/${ordineId}/items`;
  
  return ordiniRigheApi._request("get", customUrl);
}

// Le implementazioni custom di 'insert', 'update', e 'remove' sono state rimosse
// perché erano errate e puntavano a endpoint sbagliati (es. '/').
// Ora vengono utilizzati i metodi corretti forniti di default da createApiClient.

export default ordiniRigheApi;