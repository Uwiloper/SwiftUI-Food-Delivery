<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idproducto = $_POST['idproducto'] ?? '';

if (!empty($idproducto)) {
    $sql = "DELETE FROM productos WHERE idproducto = :idproducto";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idproducto', $idproducto);
    
    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
