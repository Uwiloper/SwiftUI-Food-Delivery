<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$q = isset($_GET['q']) ? trim($_GET['q']) : '';
if ($q === '') {
    echo json_encode([]);
    exit;
}

$sql = "SELECT idproducto, nombre, precio, imagenchica
        FROM productos
        WHERE nombre LIKE :q
        ORDER BY nombre
        LIMIT 50";
        
$stmt = $cn->prepare($sql);
$stmt->bindValue(':q', '%'.$q.'%');
$stmt->execute();
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>