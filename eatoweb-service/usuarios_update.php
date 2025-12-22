<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['idusuario'])) {
    echo json_encode(['success' => false, 'message' => 'ID de usuario requerido']);
    exit;
}

try {
    $campos = [];
    $params = [':idusuario' => $data['idusuario']];

    if (isset($data['usuario'])) {
        $campos[] = "usuario = :usuario";
        $params[':usuario'] = $data['usuario'];
    }
    if (isset($data['nombre'])) {
        $campos[] = "nombre = :nombre";
        $params[':nombre'] = $data['nombre'];
    }
    if (isset($data['apellido'])) {
        $campos[] = "apellido = :apellido";
        $params[':apellido'] = $data['apellido'];
    }
    if (isset($data['correo'])) {
        $campos[] = "correo = :correo";
        $params[':correo'] = $data['correo'];
    }
    if (isset($data['telefono'])) {
        $campos[] = "telefono = :telefono";
        $params[':telefono'] = $data['telefono'];
    }
    if (isset($data['clave'])) {
        $campos[] = "clave = :clave";
        $params[':clave'] = $data['clave'];
    }
    if (isset($data['foto'])) {
        $campos[] = "foto = :foto";
        $params[':foto'] = $data['foto'];
    }

    if (empty($campos)) {
        echo json_encode(['success' => false, 'message' => 'No hay datos para actualizar']);
        exit;
    }

    $sql = "UPDATE usuarios SET " . implode(", ", $campos) . " WHERE idusuario = :idusuario";
    $stmt = $cn->prepare($sql);
    $stmt->execute($params);

    echo json_encode(['success' => true, 'message' => 'Usuario actualizado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
