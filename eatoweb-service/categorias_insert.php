<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$nombre = $_POST['nombre'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$foto = $_POST['foto'] ?? '';

if (!empty($nombre)) {
    $sql = "INSERT INTO categorias (nombre, descripcion, foto) 
            VALUES (:nombre, :descripcion, :foto)";
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':descripcion', $descripcion);
    $stmt->bindParam(':foto', $foto);

    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'message' => 'Nombre requerido']);
}
?>
