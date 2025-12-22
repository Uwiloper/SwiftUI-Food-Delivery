<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idcategoria = $_POST['idcategoria'] ?? '';
$nombre = $_POST['nombre'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$foto = $_POST['foto'] ?? '';

if (!empty($idcategoria)) {
    $sql = "UPDATE categorias 
            SET nombre = :nombre, descripcion = :descripcion, foto = :foto 
            WHERE idcategoria = :idcategoria";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idcategoria', $idcategoria);
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':descripcion', $descripcion);
    $stmt->bindParam(':foto', $foto);

    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
