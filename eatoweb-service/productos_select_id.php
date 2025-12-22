<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idproducto = $_GET['idproducto'] ?? '';

if (!empty($idproducto)) {
    $sql = "SELECT * FROM productos WHERE idproducto = :idproducto";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idproducto', $idproducto);
    $stmt->execute();

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode($row);
} else {
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
