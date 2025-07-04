// === FRONTEND (React) ===
// File: CausaliManager2.jsx
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
    setFormVisible(false);
    try {
      await axios.post(`${API_BASE}/${url}`, formData);
      fetchCausali();
      setFormData({ id: "", codice: "", description: "", tipo: "" });
      setIsEditing(false);
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
      await axios.post(`${API_BASE}/delete.php`, {
        id,
      });
      fetchCausali();
    } catch (err) {
      console.error("Errore nell'eliminazione della causale:", err);
    }
  };
  return (
    <>
      {/*Sezione form */}
      {formVisible && (
        <Card sx={{ marginBottom: 2 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              {isEditing ? "Modifica Causale" : "Nuova Causale"}
            </Typography>

            <TextField
              fullWidth
              label="Codice"
              name="codice"
              value={formData.codice}
              onChange={handleChange}
            />

            <TextField
              fullWidth
              label="Descrizione"
              name="description"
              multiline
              rows={2}
              value={formData.description}
              onChange={handleChange}
            />

            <TextField
              fullWidth
              label="Tipo"
              name="tipo"
              value={formData.tipo}
              onChange={handleChange}
            />

            <Button
              onClick={() => setFormVisible(false)}
              sx={{
                mr: 2,
              }}
            >
              Annulla
            </Button>
            <Button variant="contained" onClick={handleSubmit}>
              {isEditing ? "Modifica" : "Salva"}
            </Button>
          </CardContent>
        </Card>
      )}
      {/*Sezione tabella*/}

      <Button variant="contained" color="primary" onClick={handleNew}>
        Aggiungi Causale
      </Button>

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
      {/*</Box>*/}
    </>
  );
}
export default CausaliManager2;
