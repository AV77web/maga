import React, { useState, useEffect } from "react";
import axios from "axios";

const API_BASE = "http://localhost/maga/api";

export default function RicambiDialog({ open, onClose, onSave, initialData }) {
  // initialData: { id, name, description, quantita, min, max } oppure vuoto per nuovo

  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
    quantita: "",
    min: "",
    max: "",
  });

  // Quando cambia initialData (apertura dialog), carica i dati nel form
  useEffect(() => {
    if (initialData) {
      setFormData(initialData);
    } else {
      setFormData({
        id: "",
        name: "",
        description: "",
        quantita: "",
        min: "",
        max: "",
      });
    }
  }, [initialData]);

  if (!open) return null;

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((f) => ({ ...f, [name]: value }));
  };

  const handleSubmit = async () => {
    try {
      if (formData.id) {
        // Modifica
        await axios.post(`${API_BASE}/update_ricambio.php`, formData);
      } else {
        // Inserimento
        await axios.post(`${API_BASE}/insert_ricambio.php`, formData);
      }
      if (onSave) onSave(); // per aggiornare lista
      onClose();
    } catch (err) {
      console.error("Errore salvataggio ricambio:", err);
      alert("Errore durante il salvataggio. Controlla console.");
    }
  };

  return (
    <>
      {/* Overlay */}
      <div
        onClick={onClose}
        style={{
          position: "fixed",
          inset: 0,
          backgroundColor: "rgba(0,0,0,0.5)",
          zIndex: 1000,
        }}
      />

      {/* Dialog */}
      <div
        role="dialog"
        aria-modal="true"
        style={{
          position: "fixed",
          top: "50%",
          left: "50%",
          transform: "translate(-50%, -50%)",
          backgroundColor: "#fff",
          borderRadius: 8,
          padding: 20,
          maxWidth: 480,
          width: "90%",
          maxHeight: "80vh",
          overflowY: "auto",
          zIndex: 1001,
          boxShadow: "0 2px 10px rgba(0,0,0,0.3)",
        }}
        onClick={(e) => e.stopPropagation()} // evita chiusura cliccando dentro
      >
        <h2 style={{ marginTop: 0 }}>
          {formData.id ? "Modifica Ricambio" : "Nuovo Ricambio"}
        </h2>

        <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
          <input
            type="text"
            name="name"
            placeholder="Nome"
            value={formData.name}
            onChange={handleChange}
          />
          <textarea
            name="description"
            placeholder="Descrizione"
            rows={3}
            value={formData.description}
            onChange={handleChange}
          />
          <input
            type="number"
            name="quantita"
            placeholder="Quantità"
            value={formData.quantita}
            onChange={handleChange}
          />
          <input
            type="number"
            name="min"
            placeholder="Minimo"
            value={formData.min}
            onChange={handleChange}
          />
          <input
            type="number"
            name="max"
            placeholder="Massimo"
            value={formData.max}
            onChange={handleChange}
          />
        </div>

        <div
          style={{
            marginTop: 20,
            display: "flex",
            justifyContent: "flex-end",
            gap: 10,
          }}
        >
          <button onClick={onClose}>Annulla</button>
          <button onClick={handleSubmit} style={{ fontWeight: "bold" }}>
            Salva
          </button>
        </div>
      </div>
    </>
  );
}
