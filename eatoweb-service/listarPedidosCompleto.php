<?php
header("Content-Type: application/json; charset=UTF-8");
include 'DbConnect.php'; // usa $cn (PDO)

$idusuario = isset($_GET['idusuario']) ? intval($_GET['idusuario']) : 0;

// --- CONSULTA DE PEDIDOS ---
$sqlPedidos = "SELECT idpedido, idusuario, fecha, total, metodo_pago, estado 
               FROM pedidos 
               WHERE (:idusuario = 0 OR idusuario = :idusuario)
               ORDER BY fecha DESC";

$stmtPedidos = $cn->prepare($sqlPedidos);
$stmtPedidos->bindParam(':idusuario', $idusuario, PDO::PARAM_INT);
$stmtPedidos->execute();
$pedidos = $stmtPedidos->fetchAll(PDO::FETCH_ASSOC);

foreach ($pedidos as &$pedido) {
    // --- CONSULTA DETALLE ---
    $sqlDetalle = "SELECT dp.iddetalle, dp.idproducto, p.nombre AS producto, 
                          p.imagengrande, dp.cantidad, dp.subtotal
                   FROM detalle_pedido dp
                   INNER JOIN productos p ON dp.idproducto = p.idproducto
                   WHERE dp.idpedido = :idpedido";

    $stmtDetalle = $cn->prepare($sqlDetalle);
    $stmtDetalle->bindParam(':idpedido', $pedido['idpedido'], PDO::PARAM_INT);
    $stmtDetalle->execute();
    $detalle = $stmtDetalle->fetchAll(PDO::FETCH_ASSOC);

    $pedido['productos'] = $detalle;
}

// Devolver como JSON
echo json_encode($pedidos, JSON_UNESCAPED_UNICODE);
?>
