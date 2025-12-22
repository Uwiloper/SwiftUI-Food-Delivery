<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['nombre'], $data['direccion'], $data['telefono'])) {
    echo json_encode(['success' => false, 'message' => 'Faltan datos requeridos']);
    exit;
}

try {
    $sql = "INSERT INTO restaurantes (nombre, direccion, telefono, foto, latitud, longitud)
            VALUES (:nombre, :direccion, :telefono, :foto, :latitud, :longitud)";

    $stmt = $cn->prepare($sql);
    $stmt->execute([
        ':nombre' => $data['nombre'],
        ':direccion' => $data['direccion'],
        ':telefono' => $data['telefono'],
        ':foto' => isset($data['foto']) ? $data['foto'] : 'fotos/restaurantesfotos/default.jpg',
        ':latitud' => isset($data['latitud']) ? $data['latitud'] : '',
        ':longitud' => isset($data['longitud']) ? $data['longitud'] : ''
    ]);

    echo json_encode(['success' => true, 'message' => 'Restaurante registrado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
