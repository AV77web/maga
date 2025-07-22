// c:\maga\maga\src\api\apiClientFactory.js
//======================================================
// File: apiClientFactory.js
// Script per creare client API generici e riutilizzabili
// per le risorse del backend Express.js.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2024-07-25" // Data di creazione
//======================================================

import axios from 'axios';

const API_ROOT = "http://localhost:3001/api/v1";

// Funzione generica per gestire le chiamate API con gestione degli errori
export async function baseRequest(method, url, data = null, params = null) { // Aggiunto export
  console.log("[baseRequest] CHIAMATA:", method, url, data, params);
  try {
    const token = localStorage.getItem('authToken'); // o da dove lo recuperi

    const headers = {};
    if (token) {
      headers['Authorization'] = `Bearer ${token}`;
    }

    const config = {
      method,
      url,
      headers,
    };
    if (data) {
      config.data = data;
    }
    if (params) {
      config.params = params;
    }
    console.log("[baseRequest] CONFIG:", config);
    const response = await axios(config);
    console.log("[baseRequest] RISPOSTA:", response);
    //===================================
    //Modifica per controllo errori
    //==================================
    //return response.data;
    
    //Controlla se la risposta ha una struttura comune (success/result/data)
    if (response.data && typeof response.data === 'object') {
      if (response.data.success === true) {
        // Prioritizza 'result' ( usato da ricambicontrollers.js)
        if (response.data.hasOwnProperty('result')) {
          return response.data.result;
        }
        // Fallback a 'data' (usato da CrudHandlers.js per altre entità)
        else if (response.data.hasOwnProperty('data')) {
          return response.data.data;
        } 
        // Se 'success' è true ma non ci sono 'result' o 'data', restituisci l'oggetto completo
        return response.data; 
      } else if (response.data.success === false) {
        //  Se 'success' è esplicitamente false, lancia l'errore dal sever
       throw new Error(response.data.message || response.data.error || "Operazione fallita.");
       }
    }
    // Se non c'è una struttura comune (es. risposta diretta di un arrat o stringa), restituisci i dati grezzi
    return response.data;


  } catch (error) {
    const errorMessage = error.response?.data?.error || "Errore nella comunicazione con il server";
    // Log più dettagliato dell'errore
    console.error(`[API ERROR] ${method.toUpperCase()} ${url}: ${errorMessage}`, error.response || error);
        if (error.response && (error.response.status === 401 || error.response.status === 403)) {
      // Esempio: reindirizza al login o gestisci la sessione scaduta
      console.warn("Token non valido o scaduto. Potrebbe essere necessario un re-login.");
      // window.location.href = '/login'; // Esempio di reindirizzamento
    }
    throw new Error(errorMessage);
  }
}

/**
 * Crea un client API per una specifica risorsa.
 * @param {string} resourceName - Il nome della risorsa (es. "diba", "movimenti").
 * @returns {object} Un oggetto client API con metodi standard.
 */
export function createApiClient(resourceName) {
  const API_BASE_URL = `${API_ROOT}/${resourceName}`;

  const client = {
    _apiBaseUrl: API_BASE_URL,
    _request: baseRequest, // Esponi baseRequest per chiamate personalizzate se necessario

    /**
     * Recupera tutte le risorse con eventuali parametri di query (es. paginazione, ordinamento)
     * Se params è omesso o null, verranno usati i valori di default definiti dal backend.
     */
    fetchAll: (params = null) => baseRequest("get", API_BASE_URL, null, params),

    /**
     * Recupera una risorsa specifica per ID.
     * @param {string|number} id - L'ID della risorsa.
     * @returns {Promise<object>}
     */
    fetchById: (id) => baseRequest("get", `${API_BASE_URL}/${id}`),

    /**
     * Inserisce una nuova risorsa.
     * @param {object} data - I dati della risorsa da inserire.
     * @returns {Promise<object>}
     */
    insert: (data) => baseRequest("post", API_BASE_URL, data),

    /**
     * Aggiorna una risorsa esistente.
     * @param {string|number} id - L'ID della risorsa da aggiornare.
     * @param {object} data - I dati aggiornati.
     * @returns {Promise<object>}
     */
    update: (id, data) => baseRequest("put", `${API_BASE_URL}/${id}`, data),

    /**
     * Elimina una risorsa.
     * @param {string|number} id - L'ID della risorsa da eliminare.
     * @returns {Promise<object>} // Spesso le API DELETE restituiscono 204 No Content o l'oggetto eliminato
     */
    delete: (id) => baseRequest("delete", `${API_BASE_URL}/${id}`),

    /**
     * Recupera risorse in base a filtri (come parametri query).
     * @param {object} filters - Un oggetto contenente i parametri di filtro.
     * @returns {Promise<Array<object>>}
     */
    fetchByFilters: (filters) => baseRequest("get", API_BASE_URL, null, filters),
  };

  return client;
}
