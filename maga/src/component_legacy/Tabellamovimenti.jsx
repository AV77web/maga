//=====================================
//File: TabellaMovimenti.jsx
//Programma per la visualizzazione dei movimenti
//@author = "villari.andrea@libero.it"
//@versione = "1.0.0 2025-05-23"
//=======================================

import React, { useState, useEffect } from "react";
import axios from "axios";
import "../css/Tabellamovimenti.css";

function TabellaMovimenti() {
  const [movimenti, setMovimenti] = useState([]);

  useEffect(() => {
    axios
      .get("http://localhost/maga/api/movimenti/movimenti.php")
      .then((res) => setMovimenti(res.data))
      .catch((err) => console.error("Errore nel recupero dei movimenti:", err));
  }, []);

  return (
    <div>
      <h2>Movimenti</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Descrizione</th>
            <th>Quantità</th>
            <th>Causale</th>
            <th>Data</th>
          </tr>
        </thead>
        <tbody>
          {movimenti.map((movimento) => (
            <tr key={movimento.id}>
              <td>{movimento.id}</td>
              <td>{movimento.descrizione}</td>
              <td>{movimento.quantita}</td>
              <td>{movimento.causale}</td>
              <td>{new Date(movimento.data).toLocaleString()}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default TabellaMovimenti;
