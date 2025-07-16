//========================================
//File: fornitoriApi.js
//Script che gestisce le chiamate
//http verso le api fornitori (del back-end)
// di express
//@author: "villari.andre@libero.it"
//@version: "1.1.0 2024-07-07" // Versione aggiornata post-refactoring
//=========================================

import { createApiClient } from "./apiClientFactory";

const fornitoriApi = {
  async fetchAll(params = {}) {
    // Forza il filtro tipo=FORNITORE
    return await createApiClient("counterparties").fetchAll({ ...params, tipo: "FORNITORE" });
  },
  // Puoi aggiungere qui altri metodi specifici per fornitori se servono
};

export default fornitoriApi;
