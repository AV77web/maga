<?php
require_once 'db.php';
header("Content-Type: applicatin/json");

$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id']??'';

if ($id) {
    $stmt = $pdo->prepare("DELETE FROM causali WHERE id = ? ");
    $stmt->execute([$id]);
    echo json_encode(['success'=>  true]);
} else {
    http_response_code(400);
    echo json_encode(['error' => 'ID mancante']);
}

?>