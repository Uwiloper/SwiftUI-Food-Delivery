<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (
    !isset($data['usuario'], $data['nombre'], $data['apellido'],
    $data['correo'], $data['telefono'], $data['clave'])
) {
    echo json_encode(['success' => false, 'message' => 'Faltan datos requeridos']);
    exit;
}

try {
    $sql = "INSERT INTO usuarios (usuario, nombre, apellido, correo, telefono, clave, foto, fecha_registro)
            VALUES (:usuario, :nombre, :apellido, :correo, :telefono, :clave, :foto, NOW())";

    $stmt = $cn->prepare($sql);
    $stmt->execute([
        ':usuario' => $data['usuario'],
        ':nombre' => $data['nombre'],
        ':apellido' => $data['apellido'],
        ':correo' => $data['correo'],
        ':telefono' => $data['telefono'],
        ':clave' => $data['clave'], // Puedes usar password_hash() si deseas seguridad real
        ':foto' => isset($data['foto']) ? $data['foto'] : 'fotos/nofoto.jpg'
    ]);

    echo json_encode(['success' => true, 'message' => 'Usuario registrado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
