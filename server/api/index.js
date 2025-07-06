//===================================
//File: index.js
//Script per avviare il serve Express
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-09"
//===================================

const express = require("express");
const cors = require("cors");
const ricambiRoutes = require("./routes/ricambi");

const app = express();
app.use(cors({
  origin: 'http://localhost:5173', //
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  credentials: true //
}));
app.use(express.json());

app.use("/api/ricambi", ricambiRoutes); // tutte le rotte iniziano con /api/ricambi

const PORT = 3001;
app.listen(PORT, () => {
  console.log(`Server avviato su http://localhost:${PORT}`);
});
