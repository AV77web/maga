//========================================
//File: ricambiApi.js
//Script che gestisce le chiamate
//http verso le api ricambi (del back-end)
// di express
//@author: "villari.andre@libero.it" 
//@version: "1.1.0 2024-07-25" // Versione aggiornata post-refactoring
//=========================================

import { createApiClient } from './apiClientFactory';

const ricambiApi = createApiClient('ricambi');

// Il metodo fetchByFilters è già fornito da createApiClient.
// Se ricambiApi avesse altri metodi specifici, andrebbero aggiunti qui.

export default ricambiApi;
