<?php
require_once 'db.php';
header("Content-Type: application/json; charset=UTF-8");

$data = json_decode(file_get_contents('php://input'), true);
$id = $data['id'] ?? '';
$codice = $data['codice'] ?? '';
$description = $data['description'] ?? '';
$tipo = $data['tipo'] ?? '';

// Debug log
error_log("Received data: " . print_r($data, true));

if ($codice && $description && $tipo) {
    try {
        // Set connection charset
        $pdo->exec("SET NAMES utf8mb4");
        $pdo->exec("SET CHARACTER SET utf8mb4");
        $pdo->exec("SET character_set_connection=utf8mb4");

        // First, let's check the table structure
        $tableInfo = $pdo->query("DESCRIBE causali");
        $columns = $tableInfo->fetchAll(PDO::FETCH_COLUMN);
        error_log("Table columns: " . print_r($columns, true));

        $stmt = $pdo->prepare("INSERT INTO causali (codice, description, tipo) VALUES (:codice, :description, :tipo)");
        $params = [
            ':codice' => $codice,
            ':description' => $description,
            ':tipo' => $tipo
        ];
        error_log("Parameters to be inserted: " . print_r($params, true));
        
        $stmt->execute($params);
        $lastId = $pdo->lastInsertId();
        
        // Verify the inserted data
        $verify = $pdo->query("SELECT * FROM causali WHERE id = " . $lastId);
        $result = $verify->fetch(PDO::FETCH_ASSOC);
        error_log("Inserted data: " . print_r($result, true));
        
        echo json_encode(['success' => true, 'data' => $result]);
    } catch (PDOException $e) {
        http_response_code(500);
        error_log("Database error: " . $e->getMessage());
        echo json_encode([
            'error' => 'Errore durante l\'inserimento', 
            'details' => $e->getMessage(),
            'sql_state' => $e->getCode()
        ]);
    }
} else {
    http_response_code(400);
    echo json_encode(['error' => 'Dati mancanti', 'received' => $data]);
}
?>

