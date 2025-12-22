<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idcategoria = isset($_GET['idcategoria']) ? intval($_GET['idcategoria']) : 0;

$sql = "SELECT p.idproducto, p.nombre, p.precio, p.imagenchica
        FROM productos p
        WHERE p.idcategoria = :idcategoria
        ORDER BY p.nombre;";
$stmt = $cn->prepare($sql);
$stmt->bindValue(':idcategoria', $idcategoria, PDO::PARAM_INT);
$stmt->execute();
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>