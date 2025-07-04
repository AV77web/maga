//============================
//File: Ricambi.jsx
//Programma per la gestione dei ricambi
//@author = "villari.andrea@libero.it"
//@version = "1.0.0 2025-05-23"
//=============================

import { useState, useEffect } from "react";
import "";
function Ricambilist() {
  const [ricambi, setRicambi] = useState([]);

  useEffect(() => {
    fetch("http://localhost/ricambi/api/get_ricambi.php")
      .then((res) => res.json())
      .then((data) => setRicambi(data))
      .catch((err) => console.err);
  }, []);

  return (
    <div>
      <h2>Lista Ricambi</h2>
      <ul>
        {ricambi.map((r) => (
          <li key={r.id}>
            {r.name} - {r.description} (Q.tà: {r.quantita})
          </li>
        ))}
      </ul>
    </div>
  );
}

export default Ricambilist;
