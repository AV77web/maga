 //=======================================
 // File: DialogCustom.jsx
 // Descrizione: Componente di dialogo generico e riutilizzabile
 // per la gestione di diverse entità (Articoli, Movimenti, Causali, ecc.)
 // @author: "villari.andrea@libero.it" 
 // @version: "1.0.0 2025-06-13" 
 //=========================================

 import React from "react";
 import "../css/DialogCustom.css"; // Riusiamo lo stesso stile di base per coerenza

 export default function DialogCustom({
   open,
   onClose,
   onSubmit,
   title, // Titolo passato come prop
   submitButtonText, // Testo del pulsante di submit passato come prop
   isSubmitting, // Stato di sottomissione
   children, // Qui verranno renderizzati i campi specifici del form
   // Puoi aggiungere altre props comuni se necessario (es. maxWidth, className extra, ecc.)
 }) {
   if (!open) return null;

   return (
     <>
       {/* Overlay */}
       <div className="dialog-overlay" onClick={onClose} />

       {/* Dialog */}
       <div
         role="dialog"
         aria-modal="true"
         aria-labelledby="dialog-title" // Aggiunto per accessibilità
         onClick={(e) => e.stopPropagation()} // Impedisce la chiusura cliccando dentro il dialog
         className="dialog" // Riusiamo la classe per lo stile base
       >
         <h2 id="dialog-title">{title}</h2>

         {/* Contenuto specifico del form passato come children */}
         <div className="dialog-content"> {/* Wrapper opzionale per stilizzare il contenuto */}
           {children}
         </div>

         <div className="dialog-actions">
           <button onClick={onClose} className="annulla" disabled={isSubmitting}>
             Annulla
           </button>
           <button
             onClick={onSubmit}
             className="btn-submit"
             disabled={isSubmitting}
           >
             {isSubmitting ? "Salvataggio..." : submitButtonText}
           </button>
         </div>
       </div>
     </>
   );
 }