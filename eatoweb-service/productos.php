<?php  
include 'DbConnect.php';  

// Preparamos la base de la consulta
$sql = "SELECT * FROM productos";
$params = [];

// Verificamos si se pasa idcategoria o idrestaurante por la URL
if (isset($_GET['idcategoria'])) {
    $sql .= " WHERE idcategoria = :idcategoria";
    $params[':idcategoria'] = $_GET['idcategoria'];
} elseif (isset($_GET['idrestaurante'])) {
    $sql .= " WHERE idrestaurante = :idrestaurante";
    $params[':idrestaurante'] = $_GET['idrestaurante'];
}

// Preparamos la consulta
$rs = $cn->prepare($sql);

// Ejecutamos con los parámetros (si los hay)
$rs->execute($params);

// Obtenemos los resultados
$rows = $rs->fetchAll(PDO::FETCH_ASSOC);

// Devolvemos en formato JSON
echo json_encode($rows);
?>
