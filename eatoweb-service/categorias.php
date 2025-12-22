<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$sql = "SELECT idcategoria, nombre, descripcion, foto 
        FROM categorias 
        ORDER BY nombre";

$stmt = $cn->prepare($sql);
$stmt->execute();

$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>