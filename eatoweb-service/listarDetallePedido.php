<?php
header("Content-Type: application/json; charset=UTF-8");
include 'DbConnect.php';

if (!isset($_GET['idpedido'])) {
    echo json_encode(["status" => "error", "message" => "Falta idpedido"]);
    exit;
}

$idpedido = intval($_GET['idpedido']);

$sql = "SELECT dp.iddetalle, dp.idproducto, p.nombre AS producto, p.imagengrande, dp.cantidad, dp.subtotal
        FROM detalle_pedido dp
        INNER JOIN productos p ON dp.idproducto = p.idproducto
        WHERE dp.idpedido = ?";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idpedido);
$stmt->execute();
$result = $stmt->get_result();

$detalles = [];
while ($row = $result->fetch_assoc()) {
    $detalles[] = $row;
}

echo json_encode($detalles);
?>
