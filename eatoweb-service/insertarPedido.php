<?php
header("Content-Type: application/json; charset=UTF-8");
include 'DbConnect.php';

$data = json_decode(file_get_contents('php://input'), true);

if (!$data || !isset($data['idusuario']) || !isset($data['productos'])) {
    echo json_encode(["status" => "error", "message" => "Datos incompletos"]);
    exit;
}

$idusuario = $data['idusuario'];
$total = $data['total'] ?? 0;
$metodo_pago = $data['metodo_pago'] ?? 'Simulado';
$productos = $data['productos'];

try {
    // Insertar el pedido principal
    $stmt = $conn->prepare("INSERT INTO pedidos (idusuario, total, metodo_pago, estado) VALUES (?, ?, ?, 'Simulado')");
    $stmt->bind_param("ids", $idusuario, $total, $metodo_pago);
    $stmt->execute();
    $idpedido = $conn->insert_id;

    // Insertar los productos del pedido
    $stmtDetalle = $conn->prepare("INSERT INTO detalle_pedido (idpedido, idproducto, cantidad, subtotal) VALUES (?, ?, ?, ?)");
    foreach ($productos as $item) {
        $stmtDetalle->bind_param("iiid", $idpedido, $item['idproducto'], $item['cantidad'], $item['subtotal']);
        $stmtDetalle->execute();
    }

    echo json_encode([
        "status" => "ok",
        "message" => "Pedido registrado correctamente",
        "idpedido" => $idpedido
    ]);

} catch (Exception $e) {
    echo json_encode([
        "status" => "error",
        "message" => "Error al registrar pedido: " . $e->getMessage()
    ]);
}
?>
