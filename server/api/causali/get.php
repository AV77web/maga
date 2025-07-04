<?php 
require_once 'db.php';

header("Content-Type: application/json");

try {
$stmt = $pdo->query("SELECT * FROM causali ORDER BY id ASC");
echo json_encode($stmt->fetchAll(PDO::FETCH_ASSOC));
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        "erroe" => "Errore nel recupero delle cusali",
        "dettaglio" => $e->getMessage()
    ]);
}
?>



