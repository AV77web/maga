<?php
require_once 'db.php';

header("Access-Control-Allow-Origin": *);
header("Content-Type: application/json");

// Recupera dati POST in JSON
$data = json_decode(file_get_contents("php://input"), true);
$user = $data['user'] ?? '';
$pwd = $data['pwd'] ?? '';

if ($user && $pwd) {
    $stmt = $pdo->prepare("SELECT * FROM login WHERE user = ? LIMIT 1");
    $stmt->execute([$user]);
    $record = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($record && $pwd === $record['pwd']) {
        echo json_encode(['success' => true, 'user' => $record['user']]);
    } else {
        echo json_encode(['success' => false, 'error' => 'Credenziali non valide']);
    }
} else {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Dati mancanti']);
}
?>