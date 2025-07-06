<?php
//==========================================
//File: get_ricambi.php
//API per la lettura di tutti i recambi
//da gestione ricambi RicambiManagerDialog3.jsx
//@author: "villari.andrea@libero.it"
//@version: "1.0.0 2025-06-03"
//==========================================

header("Access-Control-Allow-Origin: *");
header('Content-Type: application/json; charset=utf-8');

require_once 'db.php';

try {
    $stmt = $pdo->query("SELECT id, name, description , quantita, min, max FROM articoli");
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

    // Restituisc sempre un array (vuoto o pieno)
    echo json_encode([
        'success' => true,
        'count' => count($rows),
        'data' => $rows
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => 'Errore del server: ',
        "details" =>  $e->getMessage()
    ]);
}
?>


