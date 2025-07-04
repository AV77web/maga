<?php 
require_once 'db.php';

header("Content-Type: application/jason");

try {
    $stmt = $pdo->query("
    SELECT m.id, m.description, m.data, c.description AS causale FROM movimenti m JOIN causali c ON m.idcau = c.id ORDER BY m.data DESC");

    $movimenti = $stmt->fetcAll(PDO::FETCH_ASSOC);
    echo json_encode($movimenti);
} catch (PDOException $e) {
    http_respnse_code(500);
    echo json_encode(['error' => 'Errore durante il recupero deo movimeti']);
}

?>