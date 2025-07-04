//=======================================
// File: c:\maga\maga\src\api\userApi.js
// Script per eseguire richieste http 
// verso il back end per ottener i dati 
// degli utenti.
// @author : "villari.andrea@libero.it"
// @version : "1.0.0 2025-07-02"
//=======================================

import { createApiClient } from './apiClientFactory';

// Crea un client API per la risorsa 'users'
// Questo client avrà automaticamente i metodi:
// fetchAll, fetchById, insert, update, delete, fetchByFilters
const userApi = createApiClient('users');
// Se in futuro avessi bisogno di una chiamata API specifica per gli utenti
// che non rientra nei metodi standard, potresti aggiungerla qui.
// Esempio:
// userApi.fetchAdmins = () => userApi._request("get", `${userApi._apiBaseUrl}/admins`);

export default userApi;