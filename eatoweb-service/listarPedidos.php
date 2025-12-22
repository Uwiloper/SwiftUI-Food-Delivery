<?php
header("Content-Type: application/json; charset=UTF-8");
include 'DbConnect.php';

if (!isset($_GET['idusuario'])) {
    echo json_encode(["status" => "error", "message" => "Falta idusuario"]);
    exit;
}

$idusuario = intval($_GET['idusuario']);

$sql = "SELECT idpedido, fecha, total, metodo_pago, estado 
        FROM pedidos 
        WHERE idusuario = ? 
        ORDER BY fecha DESC";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idusuario);
$stmt->execute();
$result = $stmt->get_result();

$pedidos = [];
while ($row = $result->fetch_assoc()) {
    $pedidos[] = $row;
}

echo json_encode($pedidos);
?>
