//=======================================
// File:RicambiDialogCustom.jsx
// Descrizione: Dialog custom per la gestione dei ricambi
// inserimtento e modifica
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-06-04"
//=========================================

import React from "react";
import "../css/RicambiDialogCustom.css";

export default function RicambiDialogCustom({
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
      <div className="ricambi-dialog-overlay" onClick={onClose} />

      {/* Dialog */}
      <div
        role="dialog"
        aria-modal="true"
        onClick={(e) => e.stopPropagation()}
        className="ricambi-dialog"
      >
        <h2>{isEditing ? "Modifica Ricambio" : "Nuovo Ricambio"}</h2>

        <label htmlFor="ricambiDialog-name">Nome:</label>
        <input
          id="ricambiDialog-name"
          type="text"
          name="name"
          placeholder="Nome"
          value={formData.name}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="ricambiDialog-description">Descrizione:</label>
        <textarea
          id="ricambiDialog-description"
          name="description"
          placeholder="Descrizione"
          rows={3}
          value={formData.description}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="ricambiDialog-quantita">Quantità:</label>
        <input
          id="ricambiDialog-quantita"
          type="number"
          name="quantita"
          placeholder="Quantità"
          value={formData.quantita}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="ricambiDialog-min">Minimo:</label>
        <input
          id="ricambiDialog-min"
          type="number"
          name="min"
          placeholder="Minimo"
          value={formData.min}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="ricambiDialog-max">Massimo:</label>
        <input
          id="ricambiDialog-max"
          type="number"
          name="max"
          placeholder="Massimo"
          value={formData.max}
          onChange={onChange}
          autoComplete="off"
        />
        <label htmlFor="ricambiDialog-supplier">Fornitore:</label>
        <input
          id="ricambiDialog-supplier"
          type="text"
          name="supplier"
          placeholder="Fornitore"
          value={formData.supplier}
          onChange={onChange}
          autoComplete="organization"
        />

        <div className="ricambi-dialog-actions">
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
