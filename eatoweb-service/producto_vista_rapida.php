<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idproducto = isset($_GET['idproducto']) ? intval($_GET['idproducto']) : 0;

$sql = "SELECT idproducto, nombre, detalle AS short_detail, precio, imagengrande, imagenchica, unidadesenexistencia
        FROM productos
        WHERE idproducto = :idproducto
        LIMIT 1";

$stmt = $cn->prepare($sql);
$stmt->bindValue(':idproducto', $idproducto, PDO::PARAM_INT);
$stmt->execute();
$row = $stmt->fetch(PDO::FETCH_ASSOC);

if (!$row) {
    echo json_encode([]);
    exit;
}
echo json_encode($row);

?>