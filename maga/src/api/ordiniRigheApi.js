//==========================================
//File: ordiniRigheApi.js
//Script che gestisce le chiamate http verso
//le api per le righe degli ordini.
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-08"
//===========================================

import { createApiClient } from './apiClientFactory';

const ordiniRigheApi = createApiClient('ordini-righe'); // Endpoint base: /api/ordini-righe

/**
 * Recupera le righe di un ordine specifico.
 * @param {string|number} ordineId - L'ID dell'ordine padre.
 * @returns {Promise<Array<object>>}
 */
ordiniRigheApi.fetchByOrdineId = (ordineId) => ordiniRigheApi._request("get", `/api/ordini/${ordineId}/righe`);

export default ordiniRigheApi;