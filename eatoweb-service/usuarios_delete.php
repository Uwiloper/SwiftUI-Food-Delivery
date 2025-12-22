<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['idusuario'])) {
    echo json_encode(['success' => false, 'message' => 'ID de usuario requerido']);
    exit;
}

try {
    $sql = "DELETE FROM usuarios WHERE idusuario = :idusuario";
    $stmt = $cn->prepare($sql);
    $stmt->execute([':idusuario' => $data['idusuario']]);

    echo json_encode(['success' => true, 'message' => 'Usuario eliminado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
