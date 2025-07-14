//========================================
//File: counterpartiesApi.js
//API client per la risorsa controparti (clienti + fornitori)
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-07-14"
//=========================================

import { createApiClient } from "./apiClientFactory";

// Base path /api/v1/counterparties
const counterpartiesApi = createApiClient("counterparties");

export default counterpartiesApi; 