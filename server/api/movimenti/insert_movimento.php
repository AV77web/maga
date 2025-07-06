<?php
require_once '../db.php';
header("Content-Type: application/json");

// Riceve i dati in formato JSON
$data = json_decode(file_get_contents("php://input"), true);

// Preleva i campi, fallback vuoti se non presenti
$codcau = $data['codcau'] ?? '';
$data_mov = $data['data'] ?? '';
$description = $data['description'] ?? '';
$tipo = $data['tipo'] ?? '';

if ($codcau && $data_mov && $description && $tipo) {
    try {
        $stmt = $pdo->prepare("INSERT INTO movimenti (codcau, data, description, tipo) VALUES (?, ?, ?, ?)");
        $stmt->execute([$codcau, $data_mov, $description, $tipo]);
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['success' => false, 'error' => 'Errore DB', 'dettaglio' => $e->getMessage()]);
    }
} else {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Dati mancanti']);
}
?>
