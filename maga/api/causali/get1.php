<?php
require_once 'db.php';

header("Content-Type: application/json");

try {
    $stmt = $pdo->query("SELECT id, descrizione FROM causali");
    $causali = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($causali);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Errore durante il recupero delle causali']);
}
?>