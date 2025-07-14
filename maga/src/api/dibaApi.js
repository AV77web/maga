//==========================================
//File: dibaApi.js
//Script che gestisce le chiamate http verso
//le api diba (del back end) di Express.js
//@author: "villari.andre@libero.it" // o standardizzare a villari.andrea@libero.it
//@version: "1.1.0 2024-07-25" // Versione aggiornata post-refactoring
//==========================================

import { createApiClient } from './apiClientFactory';

const dibaApi = createApiClient('bom');

// Aggiungiamo il metodo specifico per dibaApi che non è standard nella factory
/**
 * Recupera i componenti della distinta base per un articolo padre specifico, con paginazione lato server.
 * @param {string|number} fatherId - L'ID dell'articolo padre.
 * @param {object} params - Opzionale: { page, page_size, order_by, order_dir }
 * @returns {Promise<object>} Oggetto { rows, meta }
 */
dibaApi.fetchByFatherId = (fatherId, params = null) =>
  dibaApi._request("get", `${dibaApi._apiBaseUrl}/father/${fatherId}`, null, params);
// Se dibaApi avesse metodi specifici non coperti dalla factory,
// potrebbero essere aggiunti qui. Esempio:
// dibaApi.customDibaMethod = (params) => dibaApi._request("get", `${dibaApi._apiBaseUrl}/custom-endpoint`, null, params);

export default dibaApi;
