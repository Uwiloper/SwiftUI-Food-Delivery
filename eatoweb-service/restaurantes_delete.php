<?php
include 'DbConnect.php';
header('Content-Type: application/json; charset=utf-8');

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['idrestaurante'])) {
    echo json_encode(['success' => false, 'message' => 'ID de restaurante requerido']);
    exit;
}

try {
    $sql = "DELETE FROM restaurantes WHERE idrestaurante = :idrestaurante";
    $stmt = $cn->prepare($sql);
    $stmt->execute([':idrestaurante' => $data['idrestaurante']]);

    echo json_encode(['success' => true, 'message' => 'Restaurante eliminado correctamente']);
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => $e->getMessage()]);
}
?>
