//=========================================
//File: causaliApi.js
//Script che gestisce le chiamate http verso
//le api causali (del back-end)
//di Express. 
//@author: "villari.andrea@libero.it"
//@version: "1.1.0 2024-07-25" // Versione aggiornata post-refactoring
//=========================================

import { createApiClient } from './apiClientFactory';

const causaliApi = createApiClient('causes');

// Se causaliApi avesse metodi specifici non coperti dalla factory,
// potrebbero essere aggiunti qui.

export default causaliApi;
