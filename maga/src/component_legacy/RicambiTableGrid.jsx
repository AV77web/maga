//=======================================
//File: RicambiManagerGrid.jsx
//File di gestione dei Ricambi e dei Servizi
//author@ "villari.andrea@libero.it"
//vesrsion@ "1.0.0.0 2025-05-27"
//=======================================
import React, { useEffect, useState } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Button,
  TextField,
  Typography,
  Grid,
  Box,
  Card,
  CardContent,
} from "@mui/material";
import axios from "axios";
import "../css/RicambiManager.css";

const API_BASE = "http://localhost/maga/api";

export default function RicabiTableGrid() {
  const [ricambi, setRicambi] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
  });

  useEffect(() => {
    fetchRicambi();
  }, []);

  const fetchRicambi = async () => {
    try {
      const res = await axios.get(`${API_BASE}/get_ricambi.php`);
      setRicambi(res.data);
    } catch (err) {
      console.error("Errore nel recupero dei dati", err);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Confermi l'eliminazione?")) return;
    try {
      await axios.post(`${API_BASE}/delete_ricambio.php`, { id });
      fetchRicambi();
    } catch (err) {
      console.error("Errore durante l'eliminazione", err);
    }
  };

  const handleEdit = (item) => {
    setFormData(item);
    setIsEditing(true);
    setFormVisible(true);
  };

  const handleNew = () => {
    setFormData({ id: "", name: "", description: "" });
    setIsEditing(false);
    setFormVisible(true);
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async () => {
    const url = isEditing ? "update_ricambio.php" : "insert_ricambio.php";
    try {
      await axios.post(`${API_BASE}/${url}`, formData);
      fetchRicambi();
      setFormData(false);
      setIsEditing(false);
    } catch (err) {
      console.error("Errore nel salvataggio", err);
    }
  };
  return (
    <>
      {/* Sezione form */}
      {formVisible && (
        <Box flexBasis="400px">
          <Card>
            <CardContent>
              <Typography variant="h6" gutterBottom>
                {isEditing ? "Modifica Ricambio" : "Nuovo Ricambio"}
              </Typography>
              <Grid container spacing={2}>
                <Grid item xs={12}>
                  <TextField
                    fullWidth
                    label="Nome"
                    name="name"
                    value={formData.name}
                    onChange={handleChange}
                  />
                </Grid>
                <Grid item xs={12}>
                  <TextField
                    fullWidth
                    label="Descrizione"
                    name="description"
                    multiline
                    rows={2}
                    value={formData.description}
                    onChange={handleChange}
                  />
                </Grid>
                <Grid item xs={12}>
                  <Button onClick={() => setFormVisible(false)} sx={{ mr: 2 }}>
                    Annulla
                  </Button>
                  <Button variant="contained" onClick={handleSubmit}>
                    {isEditing ? "Aggiorna" : "Salva"}
                  </Button>
                </Grid>
              </Grid>
            </CardContent>
          </Card>
        </Box>
      )}

      {/* Sezione tabella */}
      <Box flex={1}>
        <Button variant="contained" color="primary" onClick={handleNew}>
          Aggiungi Ricambio
        </Button>

        <TableContainer component={Paper} sx={{ mt: 2 }}>
          <Table>
            <TableHead>
              <TableRow>
                <TableCell>ID</TableCell>
                <TableCell>Nome</TableCell>
                <TableCell>Descrizione</TableCell>
                <TableCell>Azioni</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {ricambi.map((row) => (
                <TableRow key={row.id}>
                  <TableCell>{row.id}</TableCell>
                  <TableCell>{row.name}</TableCell>
                  <TableCell>{row.description}</TableCell>
                  <TableCell>
                    <Button onClick={() => handleEdit(row)}>Modifica</Button>
                    <Button color="error" onClick={() => handleDelete(row.id)}>
                      Elimina
                    </Button>
                  </TableCell>
                </TableRow>
              ))}
            </TableBody>
          </Table>
        </TableContainer>
      </Box>
    </>
  );
}
