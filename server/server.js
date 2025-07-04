const express = require("express");
const app = express();

app.get("/api", (req, res) => {
  res.json({ fruits: ["banana", "orange", "apple"] });
});

app.listen(3001, () => {
  console.log("Server connesso sulla porta 3001");
});
