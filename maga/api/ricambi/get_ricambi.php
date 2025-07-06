<?php
//==========================================
// File: get_ricambi.php
// API per la lettura di tutti i ricambi
// da RicambiManagerDialog3.jsx
// @author: "villari.andrea@libero.it"
// @version: "1.0.0 2025-06-03"
//==========================================

header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json; charset=utf-8');

require_once 'db.php';

try {
    $stmt = $pdo->query("SELECT id, name, description, quantita, min, max FROM articoli");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Log opzionale
    file_put_contents(
        __DIR__ . '/logs/get_ricambi.log',
        "[" . date("Y-m-d H:i:s") . "] Recuperati " . count($rows) . " ricambi\n",
        FILE_APPEND
    );

    echo json_encode([
        'success' => true,
        'message' => 'Ricambi caricati correttamente',
        'count' => count($rows),
        'data' => $rows
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Errore del server',
        'details' => $e->getMessage()
    ]);
}
?>
