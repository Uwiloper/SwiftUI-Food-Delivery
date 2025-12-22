<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idproducto = isset($_GET['idproducto']) ? intval($_GET['idproducto']) : 0;

$sql = "SELECT p.idproducto, p.nombre, p.descripcion, p.detalle, p.precio, p.imagenchica, p.imagengrande, p.calificacion,
               c.idcategoria, c.nombre AS categoria,
               r.idrestaurante, r.nombre AS restaurante, r.direccion, r.telefono, r.foto AS restaurante_foto
        FROM productos p
        LEFT JOIN categorias c ON p.idcategoria = c.idcategoria
        LEFT JOIN restaurantes r ON p.idrestaurante = r.idrestaurante
        WHERE p.idproducto = :idproducto
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