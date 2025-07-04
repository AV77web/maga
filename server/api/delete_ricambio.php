<?php
// =============================================
// File: delete_ricambio.php
// API per la cancellazione di un articolo
// da gestione ricambi RicambiManagerDialog3.jsx
// @author: "villari.andrea@libero.it"
// @verson: "1.0.0 2025-06-03"
//=============================================


header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json");

require_once 'db.php';

$data = json_decode(file_get_contents("php://input"), true);

// Verifica che l'ID sia stato fornito e sia un numero positivo
if (!isset($data['id']) || !is_numeric($data['id']) || (int)$data['id'] <= 0) {
  http_response_code(400);
  echo json_encode(['error' => 'ID non valido o mancante']);
  exit;
}

$id = (int) $data['id'];

try {
  $stmt = $pdo->prepare("DELETE FROM articoli WHERE id = ?");
  $stmt->execute([$id]);

  if ($stmt->rowCount() > 0) {
    echo json_encode(['success' => true]);
  } else {
    http_response_code(404);
    echo json_encode(['error' => 'Articolo non trovato']);
  }
} catch (PDOException $e) {
  http_response_code(500);
  echo json_encode(['error' => 'Errore del server', 'details' => $e->getMessage()]);
}
?>
