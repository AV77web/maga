//=======================================
// File: MovimentiDialogCustom.jsx
// Descrizione: Dialog custom per la gestione dei movimenti
// inserimento e modifica.
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-06-12"
//=========================================
import React from "react";
import "../css/RicambiDialogCustom.css"; // Riusiamo lo stesso stile per coerenza

export default function MovimentiDialogCustom({
  open,
  onClose,
  onSubmit,
  isEditing,
  formData,
  onChange,
  articoliList,
  causaliList,
  loadingArticoli,
  loadingCausali,
  isSubmitting,
}) {
  if (!open) return null;

  return (
    <>
      <div className="ricambi-dialog-overlay" onClick={onClose} />
      <div
        role="dialog"
        aria-modal="true"
        aria-labelledby="movimento-dialog-title"
        onClick={(e) => e.stopPropagation()}
        className="ricambi-dialog" // Riusiamo la classe per lo stile
      >
        <h2 id="movimento-dialog-title">
          {isEditing ? "Modifica Movimento" : "Nuovo Movimento"}
        </h2>

        <label htmlFor="movimentiDialog-idart">Articolo:</label>
        <select
          id="movimentiDialog-idart"
          name="idart"
          value={formData.idart || ""}
          onChange={onChange}
          required
          disabled={
            loadingArticoli ||
            isSubmitting ||
            (isEditing && !formData.idart)
          } // Non modificabile in edit se complesso
          autoComplete="off"
        >
          <option value="">-- Seleziona Articolo --</option>
          {loadingArticoli ? (
            <option disabled>Caricamento articoli...</option>
          ) : (
            articoliList.map((art) => (
              <option key={art.id} value={art.id}>
                {art.name} (ID: {art.id})
              </option>
            ))
          )}
        </select>

        <label htmlFor="movimentiDialog-idcau">Causale:</label>
        <select
          id="movimentiDialog-idcau"
          name="idcau"
          value={formData.idcau || ""}
          onChange={onChange}
          required
          disabled={
            loadingCausali ||
            isSubmitting ||
            (isEditing && !formData.idcau)
          } // Non modificabile in edit se complesso
          autoComplete="off"
        >
          <option value="">-- Seleziona Causale --</option>
          {loadingCausali ? (
            <option disabled>Caricamento causali...</option>
          ) : (
            causaliList.map((cau) => (
              <option key={cau.id} value={cau.id}>
                {" "}
                {/* Assumendo che causale abbia 'id' e 'description' */}
                {cau.codice} - {cau.description} (ID: {cau.id})
              </option>
            ))
          )}
        </select>

        <label htmlFor="movimentiDialog-data">Data Movimento:</label>
        <input
          id="movimentiDialog-data"
          type="date"
          name="data"
          value={formData.data || ""}
          onChange={onChange}
          required
          disabled={isSubmitting}
          autoComplete="off"
        />

        <label htmlFor="movimentiDialog-quantita">Quantità:</label>
        <input
          id="movimentiDialog-quantita"
          type="number"
          name="quantita"
          placeholder="Quantità"
          value={formData.quantita || ""}
          onChange={onChange}
          required
          min="1"
          disabled={
            isSubmitting ||
            (isEditing && typeof formData.quantita !== "undefined")
          } // Non modificabile in edit se complesso
          autoComplete="off"
        />

        <label htmlFor="movimentiDialog-tipo">Tipo Movimento:</label>
        <select
          id="movimentiDialog-tipo"
          name="tipo"
          value={formData.tipo || ""}
          onChange={onChange}
          required
          disabled={isSubmitting || (isEditing && formData.tipo)} // Non modificabile in edit se complesso
          autoComplete="off"
        >
          <option value="">-- Seleziona Tipo --</option>
          <option value="C">C</option>
          <option value="S">S</option>
        </select>

        <label htmlFor="movimentiDialog-note">Note:</label>
        <textarea
          id="movimentiDialog-note"
          name="note"
          placeholder="Note aggiuntive"
          rows={3}
          value={formData.note || ""}
          onChange={onChange}
          disabled={isSubmitting}
          autoComplete="off"
        />

        <div className="ricambi-dialog-actions">
          <button onClick={onClose} className="annulla" disabled={isSubmitting}>
            Annulla
          </button>
          <button
            onClick={onSubmit}
            className="btn-submit"
            disabled={isSubmitting}
          >
            {isSubmitting
              ? "Salvataggio..."
              : isEditing
              ? "Aggiorna Nota"
              : "Salva Movimento"}
          </button>
        </div>
      </div>
    </>
  );
}
