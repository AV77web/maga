//========================================
//File: fornitoriApi.js
//Script che gestisce le chiamate
//http verso le api fornitori (del back-end)
// di express
//@author: "villari.andre@libero.it"
//@version: "1.1.0 2024-07-07" // Versione aggiornata post-refactoring
//=========================================

import { createApiClient } from "./apiClientFactory";

const fornitoriApi = createApiClient("suppliers");

// Il metodo fetchByFilters è già fornito da createApiClient.
// Se ricambiApi avesse altri metodi specifici, andrebbero aggiunti qui.

export default fornitoriApi;
