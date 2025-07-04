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
  Card,
  CardContent,
  Typography,
  Grid,
} from "@mui/material";
import axios from "axios";

const API_BASE = "http://localhost/maga/api";

export default function RicambiTable() {
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
      console.error("Errore nel recupero dei dati:", err);
    }
  };

  const handleDelete = async (id) => {
    if (!window.confirm("Confermi l'eliminazione?")) return;
    try {
      await axios.post(`${API_BASE}/delete_ricambi.php`, { id });
      fetchRicambi();
    } catch (err) {
      console.error("Errore durante l'eliminazione:", err);
    }
  };

  const handleOpenDialog = (item = { id: "", name: "", description: "" }) => {
    setFormData(item);
    setIsEditing(!!item.id);
    setFormVisible(true);
  };

  const handleClose = () => {
    setFormData({ id: "", name: "", description: "" });
    setFormVisible(false);
    setIsEditing(false);
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = async () => {
    const url = isEditing ? "update_ricambi.php" : "add_ricambi.php";
    try {
      await axios.post(`${API_BASE}/${url}`, formData);
      fetchRicambi();
      handleClose();
    } catch (err) {
      console.error("Errore nel salvataggio:", err);
    }
  };

  return (
    <>
      <Button
        variant="contained"
        color="primary"
        onClick={() => handleOpenDialog()}
      >
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
                  <Button onClick={() => handleOpenDialog(row)}>
                    Modifica
                  </Button>
                  <Button color="error" onClick={() => handleDelete(row.id)}>
                    Elimina
                  </Button>
                </TableCell>
              </TableRow>
            ))}
          </TableBody>
        </Table>
      </TableContainer>

      {formVisible && (
        <Card sx={{ mt: 3, p: 2 }}>
          <CardContent>
            <Typography variant="h6" gutterBottom>
              {isEditing ? "Modifica Ricambio" : "Nuovo Ricambio"}
            </Typography>
            <Grid container spacing={2}>
              <Grid item xs={12} sm={6}>
                <TextField
                  fullWidth
                  label="Nome"
                  name="name"
                  value={formData.name}
                  onChange={handleChange}
                />
              </Grid>
              <Grid item xs={12} sm={6}>
                <TextField
                  fullWidth
                  label="Descrizione"
                  name="description"
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
      )}
    </>
  );
}
