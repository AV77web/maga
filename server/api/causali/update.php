<?php 
require_once 'db.php';
header('Content-Type: application/json');

$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'] ?? '';
$codice = $data['codice'] ?? '';
$description = $data['description'] ?? '';
$tipo = $data['tipo'] ?? '';

if ($id && $codice && $description && $tipo) {
    try {
        $stmt = $pdo->prepare("UPDATE causali SET codice = ?, description = ?, tipo = ? WHERE id = ?");
        $stmt->execute([$codice, $description, $tipo, $id]);
        echo json_encode(['success' => true]);
    } catch (PDOException $e) {
        http_response_code(500);
        echo json_encode(['error' => 'Errore durante l\'aggiornamento', 'details' => $e->getMessage()]);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Dati mancanti', 'received' => $data]);
}
?>