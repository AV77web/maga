//================================
// File: CausaliDialog.jsx
// componente per la gsetine dell'inserimento
// e modifica  delle causali di movimento
// @author: "villari.andrea@libero.it"
// version: ""
//=====================================
import React from "react";
import "../css/CausaliDialog.css";

export default function CausaliDialog({
  open,
  onClose,
  onSubmit,
  isEditing,
  formData,
  onChange,
}) {
  if (!open) return null;

  return (
    <>
      {/* Overlay */}
      <div className="causali-dialog-overlay" onClick={onClose} />

      {/* Dialog */}
      <div
        role="dialog"
        aria-modal="true"
        onClick={(e) => e.stopPropagation()}
        className="causali-dialog"
      >
        <h2>{isEditing ? "Modifica Causale" : "Nuovo Causale"}</h2>

        <label htmlFor="causaliDialog-codice">Codice:</label>
        <input
          id="causaliDialog-codice"
          type="text"
          name="codice"
          placeholder="Codice"
          value={formData.codice}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="causaliDialog-description">Descrizione:</label>
        <textarea
          id="causaliDialog-description"
          name="description"
          placeholder="Descrizione"
          rows={3}
          value={formData.description}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="causaliDialog-tipo">Tipo:</label>
        <input
          id="causaliDialog-tipo"
          type="text" // Corrected: type="text" instead of "tipo"
          name="tipo" // Corrected: name="tipo" instead of "Tipo"
          placeholder="Tipo"
          value={formData.tipo}
          onChange={onChange}
          autoComplete="off"
        />

        <div className="causali-dialog-actions">
          <button onClick={onClose} className="annulla">
            Annulla
          </button>
          <button onClick={onSubmit} className="btn-submit">
            {isEditing ? "Aggiorna" : "Salva"}
          </button>
        </div>
      </div>
    </>
  );
}
