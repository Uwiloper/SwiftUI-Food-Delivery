<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$sql = "SELECT idrestaurante, nombre, direccion, telefono, foto, latitud, longitud
        FROM restaurantes 
        ORDER BY nombre";

$stmt = $cn->prepare($sql);
$stmt->execute();

$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>