// === FRONTEND (React) ===
// File: CausaliManager2.jsx
// Gestione causali magazzino con form modale

import React, { useState, useEffect } from "react";
import axios from "axios";
import "../css/CausaliManager.css";
import {
  Button,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TextField,
  Typography,
} from "@mui/material";

const API_BASE = "http://localhost/maga/api/causali";

function CausaliManager2() {
  const [causali, setCausali] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    codice: "",
    description: "",
    tipo: "",
  });

  const fetchCausali = async () => {
    try {
      const res = await axios.get(`${API_BASE}/get.php`);
      setCausali(res.data);
    } catch (err) {
      console.error("Errore nel caricamento delle causali:", err);
    }
  };

  useEffect(() => {
    fetchCausali();
  }, []);

  const handleNew = () => {
    setFormData({ id: "", codice: "", description: "", tipo: "" });
    setIsEditing(false);
    setFormVisible(true);
  };

  const handleChange = (e) => {
    setFormData({ ...formData, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const url = formData.id ? "update.php" : "add.php";
    try {
      await axios.post(`${API_BASE}/${url}`, formData);
      fetchCausali();
      setFormData({ id: "", codice: "", description: "", tipo: "" });
      setIsEditing(false);
      setFormVisible(false);
    } catch (err) {
      console.error("Errore nel salvataggio della causale:", err);
    }
  };

  const handleEdit = (causale) => {
    setFormData(causale);
    setIsEditing(true);
    setFormVisible(true);
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Sei sicuro di voler eliminare questa causale?"))
      return;
    try {
      await axios.post(`${API_BASE}/delete.php`, { id });
      fetchCausali();
    } catch (err) {
      console.error("Errore nell'eliminazione della causale:", err);
    }
  };

  return (
    <>
      {/* Form in modale */}
      <Dialog
        open={formVisible}
        onClose={() => setFormVisible(false)}
        fullWidth
        maxWidth="sm"
      >
        <DialogTitle>
          {isEditing ? "Modifica Causale" : "Nuova Causale"}
        </DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            margin="normal"
            label="Codice"
            name="codice"
            value={formData.codice}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Descrizione"
            name="description"
            multiline
            rows={2}
            value={formData.description}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="normal"
            label="Tipo"
            name="tipo"
            value={formData.tipo}
            onChange={handleChange}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setFormVisible(false)}>Annulla</Button>
          <Button variant="contained" onClick={handleSubmit}>
            {isEditing ? "Modifica" : "Salva"}
          </Button>
        </DialogActions>
      </Dialog>

      {/* Bottone per aggiungere */}
      <Button
        variant="contained"
        color="primary"
        onClick={handleNew}
        sx={{ my: 2 }}
      >
        Aggiungi Causale
      </Button>

      {/* Tabella */}
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

export default CausaliManager2;
