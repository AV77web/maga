// c:\maga\maga\src\api\authApi.js
//======================================================
// File: authApi.js
// Script per le chiamate API relative all'autenticazione.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2024-07-29"
//======================================================
import { baseRequest } from './apiClientFactory'; // Assumendo che baseRequest sia esportato da apiClientFactory.js

const API_AUTH_ROOT = "http://localhost:3001/api/auth"; // Assicurati che la porta sia corretta

export const logoutUser = async () => {
  try {
    // Questa chiamata è per convenzione API o per future logiche server-side (es. blacklist).
    // Il logout effettivo avviene client-side rimuovendo il token.
    const response = await baseRequest("post", `${API_AUTH_ROOT}/logout`);
    return response; // Dovrebbe restituire { success: true, message: '...' }
  } catch (error) {
    // Anche se la chiamata server fallisce, il client dovrebbe procedere con la rimozione locale del token.
    console.warn("Chiamata di logout al server fallita, si procede con il logout client-side:", error.message);
    // Restituisce un successo sintetico per non bloccare la rimozione del token client-side.
    return { success: true, message: "Logout server fallito, ma la sessione client sarà pulita." };
  }
};

// Altre funzioni come loginUser, registerUser potrebbero essere qui se non gestite direttamente nei componenti.