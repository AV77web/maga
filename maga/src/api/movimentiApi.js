//=============================================
//File: movimentiApi.js
//Script che gestisce le chiamate
//http verso le api movimenti (del back-end)
//di express
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2024-07-25" // Versione aggiornata post-refactoring
//=============================================

import { createApiClient } from './apiClientFactory';

const movimentiApi = createApiClient('movements');

// Aggiungiamo il metodo specifico per movimentiApi che non è standard nella factory
/**
 * Esegue una query SQL custom sul backend.
 * @param {string} querySql - La stringa della query SQL.
 * @returns {Promise<object>}
 */
movimentiApi.fetchCustomQuery = (querySql) =>
  movimentiApi._request("post", `${movimentiApi._apiBaseUrl}/customquery`, { query: querySql });

// Il metodo fetchByFilters è già fornito da createApiClient

export default movimentiApi;
