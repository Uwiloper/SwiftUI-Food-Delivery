<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idcategoria = $_POST['idcategoria'] ?? '';

if (!empty($idcategoria)) {
    $sql = "DELETE FROM categorias WHERE idcategoria = :idcategoria";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idcategoria', $idcategoria);

    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
