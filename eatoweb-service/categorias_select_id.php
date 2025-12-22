<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idcategoria = $_GET['idcategoria'] ?? '';

if (!empty($idcategoria)) {
    $sql = "SELECT idcategoria, nombre, descripcion, foto 
            FROM categorias 
            WHERE idcategoria = :idcategoria";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idcategoria', $idcategoria);
    $stmt->execute();

    $row = $stmt->fetch(PDO::FETCH_ASSOC);
    echo json_encode($row);
} else {
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
