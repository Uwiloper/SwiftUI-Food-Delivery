<?php
// crear_pedido.php
// Recibe (POST):
// idusuario (opcional), direccion, telefono, items (JSON string)
// items = [ { "idproducto":1, "nombre_producto":"...", "cantidad":2, "precio_unitario":12.5 }, ... ]

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idusuario = isset($_POST['idusuario']) && $_POST['idusuario'] !== '' ? intval($_POST['idusuario']) : null;
$direccion = isset($_POST['direccion']) ? $_POST['direccion'] : null;
$telefono  = isset($_POST['telefono']) ? $_POST['telefono'] : null;
$items_json = isset($_POST['items']) ? $_POST['items'] : '[]';

$items = json_decode($items_json, true);
if (!is_array($items) || count($items) === 0) {
    echo json_encode(['error' => 'items inválidos o vacíos']);
    exit;
}

// calcular total
$total = 0.0;
foreach ($items as $it) {
    $cantidad = isset($it['cantidad']) ? intval($it['cantidad']) : 1;
    $precio = isset($it['precio_unitario']) ? floatval($it['precio_unitario']) : 0.0;
    $total += $cantidad * $precio;
}

try {
    $cn->beginTransaction();
    $sql = "INSERT INTO pedidos (idusuario, total, direccion_envio, telefono) VALUES (?, ?, ?, ?)";
    $stmt = $cn->prepare($sql);
    $stmt->execute([$idusuario, $total, $direccion, $telefono]);
    $idpedido = $cn->lastInsertId();

    $sqlDet = "INSERT INTO detalle_pedidos (idpedido, idproducto, nombre_producto, cantidad, precio_unitario, subtotal) VALUES (?, ?, ?, ?, ?, ?)";
    $stmtDet = $cn->prepare($sqlDet);
    foreach ($items as $it) {
        $idprod = isset($it['idproducto']) ? intval($it['idproducto']) : 0;
        $nombre = isset($it['nombre_producto']) ? $it['nombre_producto'] : '';
        $cantidad = isset($it['cantidad']) ? intval($it['cantidad']) : 1;
        $precio = isset($it['precio_unitario']) ? floatval($it['precio_unitario']) : 0.0;
        $subtotal = $cantidad * $precio;
        $stmtDet->execute([$idpedido, $idprod, $nombre, $cantidad, $precio, $subtotal]);
    }
    $cn->commit();
    echo json_encode(['ok' => true, 'idpedido' => $idpedido]);
} catch (Exception $e) {
    $cn->rollBack();
    echo json_encode(['error' => $e->getMessage()]);
}

?>