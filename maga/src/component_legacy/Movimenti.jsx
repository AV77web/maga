//==================================
//File: Movimenti.jsx
//Programma per la gestione dei movimenti
//@author = "villari.andrea@libero.it"
//@version = "1.0.0 2025-05-21"
//===================================

import { useState, useEffect } from "react";
import axios from "axios";
import "../css/Movimenti.css";
function MovimentoForm() {
  const [causali, setCausali] = useState([]);
  const [movimento, setMovimento] = useState({
    descrizione: "",
    quantita: "",
    causale_id: "",
  });

  useEffect(() => {
    axios
      .get("http://localhost/api/causali.php")
      .then((res) => setCausali(res.data))
      .catch((err) => console.error("Errore caricamento causali:", err));
  }, []);

  const handleChange = (e) => {
    setMovimento({ ...movimento, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await axios.post(
        "http://localhost/api/aggiungi_movimento.php",
        movimento
      );
      alert("Movimento registrato!");
    } catch (err) {
      alert("Errore durante l'inserimento");
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input
        name="descrizione"
        placeholder="Descrizione"
        onChange={handleChange}
        required
      />
      <input name="quantita" type="number" onChange={handleChange} required />
      <select name="causale_id" onChange={handleChange} required>
        <option value="">Seleziona causale</option>
        {causali.map((c) => (
          <option key={c.id} value={c.id}>
            {c.descrizione}
          </option>
        ))}
      </select>
      <button type="submit">Salva</button>
    </form>
  );
}

export default MovimentoForm;
