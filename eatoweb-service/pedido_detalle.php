<?php
// pedido_detalle.php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idpedido = isset($_GET['idpedido']) ? intval($_GET['idpedido']) : 0;
$sql = "SELECT iddetalle, idproducto, nombre_producto, cantidad, precio_unitario, subtotal
        FROM detalle_pedidos
        WHERE idpedido = :idpedido";
$stmt = $cn->prepare($sql);
$stmt->bindValue(':idpedido', $idpedido, PDO::PARAM_INT);
$stmt->execute();
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>