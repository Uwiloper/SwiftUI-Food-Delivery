<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['idrestaurante'])) {
    echo json_encode(['success' => false, 'message' => 'ID de restaurante requerido']);
    exit;
}

try {
    $campos = [];
    $params = [':idrestaurante' => $data['idrestaurante']];

    if (isset($data['nombre'])) {
        $campos[] = "nombre = :nombre";
        $params[':nombre'] = $data['nombre'];
    }
    if (isset($data['direccion'])) {
        $campos[] = "direccion = :direccion";
        $params[':direccion'] = $data['direccion'];
    }
    if (isset($data['telefono'])) {
        $campos[] = "telefono = :telefono";
        $params[':telefono'] = $data['telefono'];
    }
    if (isset($data['foto'])) {
        $campos[] = "foto = :foto";
        $params[':foto'] = $data['foto'];
    }
    if (isset($data['latitud'])) {
        $campos[] = "latitud = :latitud";
        $params[':latitud'] = $data['latitud'];
    }
    if (isset($data['longitud'])) {
        $campos[] = "longitud = :longitud";
        $params[':longitud'] = $data['longitud'];
    }

    if (empty($campos)) {
        echo json_encode(['success' => false, 'message' => 'No hay datos para actualizar']);
        exit;
    }

    $sql = "UPDATE restaurantes SET " . implode(", ", $campos) . " WHERE idrestaurante = :idrestaurante";
    $stmt = $cn->prepare($sql);
    $stmt->execute($params);

    echo json_encode(['success' => true, 'message' => 'Restaurante actualizado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
