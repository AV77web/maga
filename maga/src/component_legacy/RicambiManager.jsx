//==============================================
//File: RicambiManager.jsx
//Programma per la gestione dei ricambi e dei servizi
//@author = "villari.andrea@libero.it"
//@versione = "1.0.0 2025-05-23"
//===============================================

import React, { useState, useEffect } from "react";
import "../css/RicambiManager.css";

function RicambiManager() {
  const [ricambi, setRicambi] = useState([]);

  const [formData, setFormData] = useState({
    id: "",
    name: "",
    description: "",
  });

  useEffect(() => {
    fetchRicambi();
  }, []);

  const fetchRicambi = () => {
    fetch("/ricambi/api/get_ricambi.php")
      .then((res) => res.json())
      .then((data) => setRicambi(data))
      .catch((err) =>
        console.error("Errore nel caricamento dei ricambi:", err)
      );
  };

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    const url = formData.id
      ? "/ricambi/api/update_ricambio.php"
      : "/ricambi/api/insert_ricambio.php";

    fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(formData),
    })
      .then((res) => res.json())
      .then(() => {
        fetchRicambi();
        setFormData({ id: "", name: "", description: "" });
      })
      .catch((err) =>
        console.error("Errore nella sottomissione del form:", err)
      );
  };

  const handleEdit = (ricambio) => {
    setFormData(ricambio);
  };

  const handleDelete = (id) => {
    if (window.confirm("Sei sicuro di voler eliminare questo ricambio?")) {
      fetch("/ricambi/api/delete_ricambio.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ id }),
      })
        .then((res) => res.json())
        .then(() => fetchRicambi())
        .catch((err) => console.error("Errore nella cancellazione:", err));
    }
  };

  return (
    <div>
      <h2>Gestione Ricambi</h2>
      <form onSubmit={handleSubmit}>
        <label htmlFor="id">ID:</label>
        <input type="text" name="id" value={formData.id} readOnly required />
        <label htmlFor="name">Nome:</label>
        <input
          type="text"
          name="name"
          placeholder="Nome"
          value={formData.name}
          onChange={handleChange}
          required
        />
        <input
          type="text"
          name="description"
          placeholder="Descrizione"
          value={formData.description}
          onChange={handleChange}
          required
        />
        <button type="submit">{formData.id ? "Aggiorna" : "Aggiungi"}</button>
        {formData.id && (
          <button
            type="button"
            onClick={() => setFormData({ id: "", name: "", description: "" })}
          >
            Annulla
          </button>
        )}
      </form>
      <div>
        <table>
          <thead>
            <tr>
              <th>ID</th>
              <th>Nome</th>
              <th>Descrizione</th>
              <th>Azioni</th>
            </tr>
          </thead>
          <tbody>
            {ricambi.map((r) => (
              <tr key={r.id}>
                <td>{r.id}</td>
                <td>{r.name}</td>
                <td>{r.description}</td>
                <td>
                  <button onClick={() => handleEdit(r)}>Modifica</button>
                  <button onClick={() => handleDelete(r.id)}>Elimina</button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default RicambiManager;
