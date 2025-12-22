<?php

include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idusuario = isset($_GET['idusuario']) ? intval($_GET['idusuario']) : 0;
$sql = "SELECT idpedido, idusuario, fecha, total, estado, direccion_envio, telefono, notas FROM pedidos
        WHERE idusuario = :idusuario
        ORDER BY fecha DESC
        LIMIT 100";

$stmt = $cn->prepare($sql);
$stmt->bindValue(':idusuario', $idusuario, PDO::PARAM_INT);
$stmt->execute();
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
echo json_encode($rows);

?>