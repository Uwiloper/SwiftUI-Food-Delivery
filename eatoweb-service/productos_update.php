<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$idproducto = $_POST['idproducto'] ?? '';
$nombre = $_POST['nombre'] ?? '';
$descripcion = $_POST['descripcion'] ?? '';
$precio = $_POST['precio'] ?? '';
$idcategoria = $_POST['idcategoria'] ?? '';
$idrestaurante = $_POST['idrestaurante'] ?? '';
$imagengrande = $_POST['imagengrande'] ?? '';
$imagenchica = $_POST['imagenchica'] ?? '';
$foto_original = $_POST['foto_original'] ?? null;
$calificacion = $_POST['calificacion'] ?? null;

if (!empty($idproducto)) {
    $sql = "UPDATE productos 
            SET nombre = :nombre, descripcion = :descripcion, precio = :precio, 
                idcategoria = :idcategoria, idrestaurante = :idrestaurante,
                imagengrande = :imagengrande, imagenchica = :imagenchica,
                foto_original = :foto_original, calificacion = :calificacion,
                updated_at = NOW()
            WHERE idproducto = :idproducto";

    $stmt = $cn->prepare($sql);
    $stmt->bindParam(':idproducto', $idproducto);
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
    echo json_encode(['success' => false, 'message' => 'ID requerido']);
}
?>
