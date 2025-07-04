// === FRONTEND (React) ===
// File: CausaliManager.jsx
// File di gestione delle causali di carico e scarico magazzino.
// @author = "villari.andrea@libero.it"
// @version = "1.0.0 2025-05-23"
// =========================

import React, { useState, useEffect } from "react";
import axios from "axios";
import "../css/CausaliManager.css";
import {
  Box,
  Button,
  Card,
  CardContent,
  Grid,
  Paper,
  Table,
  TableBody,
  TableCell,
  TableRow,
} from "@mui/material";

const API_BASE = "http://localhost/maga/api/causali";

function CausaliManager() {
  const [causali, setCausali] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  /*const [isEditing, setIsEditing] = useState(false);*/
  const [formData, setFormData] = useState({
    id: "",
    codice: "",
    description: "",
    tipo: "",
  });

  const fetchCausali = async () => {
    try {
      const res = await axios.get("/maga/api/causali/get.php");
      setCausali(res.data);
    } catch (err) {
      console.error("Errore nel caricamento delle causali:", err);
    }
  };

  useEffect(() => {
    fetchCausali();
  }, []);

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const url = formData.id
      ? "/maga/api/causali/update.php"
      : "/maga/api/causali/add.php";

    try {
      await axios.post(`${API_BASE}/${url}`, formData);
      fetchCausali();
      setFormData({ id: "", codice: "", description: "", tipo: "" });
    } catch (err) {
      console.error("Errore nel salvataggio della causale:", err);
    }
  };

  const handleEdit = (causale) => {
    setFormData(causale);
    setIsEditign(true);
    setFormVisible(true);
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Sei sicuro di voler eliminare questa causale?"))
      return;
    try {
      await axios.post(`${API_BASE}/maga/causali/api/delete.php`, {
        id,
      });
      fetchCausali();
    } catch (err) {
      console.error("Errore nell'eliminazione della causale:", err);
    }
  };

  return (
    <>
      <h2>Gestione Causali</h2>
      <form onSubmit={handleSubmit}>
        <input
          name="codice"
          placeholder="Codice"
          value={formData.codice}
          onChange={handleChange}
          required
        />
        <input
          name="description"
          placeholder="Descrizione"
          value={formData.description}
          onChange={handleChange}
          required
        />
        <input
          name="tipo"
          placeholder="Tipo"
          value={formData.tipo}
          onChange={handleChange}
          required
        />
        <button type="submit">{formData.id ? "Aggiorna" : "Aggiungi"}</button>
        {formData.id && (
          <button
            type="button"
            onClick={() =>
              setFormData({ id: "", codice: "", description: "", tipo: "" })
            }
          >
            Annulla
          </button>
        )}
      </form>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Codice</th>
            <th>Descrizione</th>
            <th>Tipo</th>
            <th>Azioni</th>
          </tr>
        </thead>
        <tbody>
          {causali.map((c) => (
            <tr key={c.id}>
              <td>{c.id}</td>
              <td>{c.codice}</td>
              <td>{c.description}</td>
              <td>{c.tipo}</td>
              <td>
                <button onClick={() => handleEdit(c)}>Modifica</button>
                <button onClick={() => handleDelete(c.id)}>Elimina</button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </>
  );
}

export default CausaliManager;
