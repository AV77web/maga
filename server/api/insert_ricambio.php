<?php
//==========================================
//File: insert_ricambio.php
//API per l'inserimento dii un nuovo articolo
//da gestion recambi RicambiManagerDialog3.jsx
//@aithor: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-03"
//===========================================
require_once 'db.php';

$data = json_decode(file_get_contents("php://input"), true);
$name = $data['name'] ?? '';
$description = $data['description'] ?? '';
$quantita = $data['quantita'] ?? '';
$min = $data['min'] ?? '';
$max = $data['max'] ?? '';

if ($name && $description && $quantita && $min && $max) {
  $stmt = $pdo->prepare("INSERT INTO articoli (name, description, quantita, min, max) VALUES (?, ?)");
  $stmt->execute([$name, $description, $quantita, $min. $max]);
  echo json_encode(['success' => true]);
} else {
  http_response_code(400);
  echo json_encode(['error' => 'Dati mancanti']);
}
?>
