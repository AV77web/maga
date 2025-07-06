//==============================
// File :RicambiManagerDialog.jsx
// Versione con Dialog per inserimento/modifica
// + paginazione
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-05-29"
//==============================

// RicambiManagerDialog.jsx
// Versione con Dialog per inserimento/modifica + paginazione compatta

import React, { useEffect, useState, useMemo } from "react";
import {
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Paper,
  Button,
  Box,
  TextField,
  Dialog,
  DialogTitle,
  DialogContent,
  DialogActions,
  TablePagination,
  GlobalStyles,
} from "@mui/material";
import axios from "axios";
import Pagination from "./Pagination";

import "../css/RicambiManager.min.css";

const API_BASE = "http://localhost/maga/api";
const rowsPerPageOptions = [5, 10, 20, 50];

export default function RicambiManagerDialog() {
  const [ricambi, setRicambi] = useState([]);
  const [formVisible, setFormVisible] = useState(false);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
    quantita: "",
    min: "",
    max: "",
  });
  const [page, setPage] = useState(0);
  const [rowsPerPage, setRowsPerPage] = useState(10);

  // Paginazione
  const currentTableData = useMemo(() => {
    const firstPageIndex = page * rowsPerPage;
    const lastPageIndex = firstPageIndex + rowsPerPage;
    return ricambi.slice(firstPageIndex, lastPageIndex);
  }, [page, rowsPerPage, ricambi]);

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
    setFormData({
      id: "",
      name: "",
      description: "",
      quantita: "",
      min: "",
      max: "",
    });
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
      setFormVisible(false);
    } catch (err) {
      console.error("Errore nel salvataggio", err);
    }
  };

  const handleChangePage = (event, newPage) => {
    setPage(newPage);
  };

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  const paginatedData = ricambi.slice(
    page * rowsPerPage,
    page * rowsPerPage + rowsPerPage
  );

  return (
    <>
      <Dialog
        open={formVisible}
        onClose={() => setFormVisible(false)}
        fullWidth
        maxWidth="sm"
        scroll="paper"
        PaperProps={{
          sx: {
            position: "absolute",
            top: "50%",
            left: "50%",
            transform: "translate(-50%, -50%)",
            m: 0,
            minHeight: "400px",
            maxHeight: "90vh",
            display: "flex",
            flexDirection: "column",
            justifyContent: "space-between",
            p: 3,
          },
        }}
      >
        <DialogTitle>
          {isEditing ? "Modifica Ricambio" : "Nuovo Ricambio"}
        </DialogTitle>
        <DialogContent>
          <TextField
            fullWidth
            margin="dense"
            label="Nome"
            name="name"
            value={formData.name}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="dense"
            label="Descrizione"
            name="description"
            multiline
            rows={2}
            value={formData.description}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="dense"
            label="Quantità"
            name="quantita"
            value={formData.quantita}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="dense"
            label="Minimo"
            name="min"
            value={formData.min}
            onChange={handleChange}
          />
          <TextField
            fullWidth
            margin="dense"
            label="Massimo"
            name="max"
            value={formData.max}
            onChange={handleChange}
          />
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setFormVisible(false)}>Annulla</Button>
          <Button variant="contained" onClick={handleSubmit}>
            {isEditing ? "Aggiorna" : "Salva"}
          </Button>
        </DialogActions>
      </Dialog>

      <Button
        variant="contained"
        color="primary"
        onClick={handleNew}
        sx={{ my: 2 }}
      >
        Aggiungi Ricambio
      </Button>

      <TableContainer component={Paper}>
        <Table>
          <TableHead>
            <TableRow>
              <TableCell>ID</TableCell>
              <TableCell>Nome</TableCell>
              <TableCell>Descrizione</TableCell>
              <TableCell>Quantita</TableCell>
              <TableCell>Minimo</TableCell>
              <TableCell>Massimo</TableCell>
              <TableCell>Azioni</TableCell>
            </TableRow>
          </TableHead>
          <TableBody>
            {currentTableData.map((row) => (
              <TableRow key={row.id}>
                <TableCell>{row.id}</TableCell>
                <TableCell>{row.name}</TableCell>
                <TableCell>{row.description}</TableCell>
                <TableCell>{row.quantita}</TableCell>
                <TableCell>{row.min}</TableCell>
                <TableCell>{row.max}</TableCell>
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
      <Box
        sx={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
          mx: 2,
          my: 2,
        }}
      >
        <Pagination
          className="pagination-bar"
          currentPage={page + 1}
          totalCount={ricambi.length}
          pageSize={rowsPerPage}
          onPageChange={(newPage) => setPage(newPage - 1)}
        />
        <label>
          Elementi per pagina:&nbsp;
          <select
            value={rowsPerPage}
            onChange={(e) => {
              setRowsPerPage(parseInt(e.target.value, 10));
              setPage(0); // resetta a prima pagina
            }}
          >
            {rowsPerPageOptions.map((option) => (
              <option key={option} value={option}>
                {option}
              </option>
            ))}
          </select>
        </label>
      </Box>
    </>
  );
}
