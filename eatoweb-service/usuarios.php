<?php 

    include 'DbConnect.php';    

    $sql = "SELECT * FROM usuarios";
    $rs = $cn->prepare($sql);
    $rs->execute();

    $rows = $rs->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode($rows);

?>