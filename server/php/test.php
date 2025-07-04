<?php
require_once 'php/db.php';

$stmt = $pdo->query("SELECT * FROM ricambi");
$data = $stmt->fetchAll();
echo "<pre>";
print_r($data);
echo "</pre>";
?>