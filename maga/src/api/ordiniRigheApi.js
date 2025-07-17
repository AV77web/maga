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

/**
 * Inserisce una nuova riga d'ordine.
 * @param {object} rigaData - I dati della riga da inserire.
 * @returns {Promise<object>}
 */
ordiniRigheApi.insert = (rigaData) => ordiniRigheApi._request("post", "/", rigaData);

/**
 * Aggiorna una riga d'ordine esistente.
 * @param {string|number} id - L'ID della riga da aggiornare.
 * @param {object} rigaData - I nuovi dati della riga.
 * @returns {Promise<object>}
 */
ordiniRigheApi.update = (id, rigaData) => ordiniRigheApi._request("put", `/${id}`, rigaData);

/**
 * Rimuove una riga d'ordine.
 * @param {string|number} id - L'ID della riga da rimuovere.
 * @returns {Promise<object>}
 */
ordiniRigheApi.remove = (id) => ordiniRigheApi._request("delete", `/${id}`);

export default ordiniRigheApi;