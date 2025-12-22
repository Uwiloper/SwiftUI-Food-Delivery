<?php
include 'DbConnect.php';

$objDb = new DbConnect();
$cn = $objDb->connect();

// Recibir datos del formulario o app
$correotelefono = $_POST['correotelefono'];
$clave = $_POST['clave'];

// Buscar el usuario por correo o teléfono
$sql = "SELECT * FROM usuarios WHERE correo = :dato OR telefono = :dato";
$stmt = $cn->prepare($sql);
$stmt->bindParam(':dato', $correotelefono);
$stmt->execute();

$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Validar existencia del usuario
if (count($rows) == 0) {
    echo -1; // No encontrado
} else {
    $user = $rows[0];

    // Verificar la contraseña (encriptada con password_hash)
    if (!password_verify($clave, $user['clave'])) {
        echo -2; // Contraseña incorrecta
    } else {
        // Quitar la clave antes de enviar
        unset($user['clave']);

        // Enviar respuesta como JSON
        echo json_encode($user);
    }
}
?>
