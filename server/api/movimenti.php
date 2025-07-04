<?php
require_once 'db.php';

header("Content-Type: application/json");

try {
    $stmt = $pdo->query("
        SELECT m.id, m.descrizione, m.quantita, m.data, c.descrizione AS causale
        FROM movimenti m
        JOIN causali c ON m.causale_id = c.id
        ORDER BY m.data DESC
    ");
    $movimenti = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($movimenti);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['error' => 'Errore durante il recupero dei movimenti']);
}
?>
