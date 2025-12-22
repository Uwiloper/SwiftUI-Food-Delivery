<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$nombre = $_POST['nombre'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$precio = $_POST['precio'] ?? '';
$idcategoria = $_POST['idcategoria'] ?? '';
$idrestaurante = $_POST['idrestaurante'] ?? '';
$imagengrande = $_POST['imagengrande'] ?? '';
$imagenchica = $_POST['imagenchica'] ?? '';
$foto_original = $_POST['foto_original'] ?? null;
$calificacion = $_POST['calificacion'] ?? null;

if (!empty($nombre) && !empty($precio)) {
    $sql = "INSERT INTO productos (nombre, descripcion, precio, idcategoria, idrestaurante, imagengrande, imagenchica, foto_original, calificacion, created_at)
            VALUES (:nombre, :descripcion, :precio, :idcategoria, :idrestaurante, :imagengrande, :imagenchica, :foto_original, :calificacion, NOW())";
    
    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':nombre', $nombre);
    $stmt->bindParam(':descripcion', $descripcion);
    $stmt->bindParam(':precio', $precio);
    $stmt->bindParam(':idcategoria', $idcategoria);
    $stmt->bindParam(':idrestaurante', $idrestaurante);
    $stmt->bindParam(':imagengrande', $imagengrande);
    $stmt->bindParam(':imagenchica', $imagenchica);
    $stmt->bindParam(':foto_original', $foto_original);
    $stmt->bindParam(':calificacion', $calificacion);

    $success = $stmt->execute();

    echo json_encode(['success' => $success]);
} else {
    echo json_encode(['success' => false, 'message' => 'Faltan campos obligatorios']);
}
?>
