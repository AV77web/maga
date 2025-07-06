<?php
// ======================================================
// File: update_ricambio.php
// API per la modifica di un articolo da gestione ricambi
// RicambiManagerDialog3.jsx
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-06-03"
//=======================================================
header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json');
require_once 'db.php';

// Decodifica i dati JSON ricevuti dal frontend
$data = json_decode(file_get_contents("php://input"), true);

// Verifica che tutte le chiavi richieste siano presenti
if (
    !isset($data['id']) ||
    !isset($data['name']) ||
    !isset($data['description']) ||
    !isset($data['quantita']) ||
    !isset($data['min']) ||
    !isset($data['max'])
) {
    http_response_code(400);
    echo json_encode(["error" => "Dati mancanti"]);
    exit;
}

// Estrai i dati (i valori possono anche essere 0, quindi non si usa controllo "truthy")
$id = $data['id'];
$name = $data['name'];
$description = $data['description'];
$quantita = $data['quantita'];
$min = $data['min'];
$max = $data['max'];

try {
    $stmt = $pdo->prepare("UPDATE articoli SET name = ?, description = ?, quantita = ?, min = ?, max = ? WHERE id = ?");
    $stmt->execute([$name, $description, $quantita, $min, $max, $id]);
    echo json_encode(['success' => true]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Errore nel database: ' . $e->getMessage()]);
}
?>
