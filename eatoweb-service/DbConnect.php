<?php 
    //permitir acceso desde cualquier origen
    header("Access-Control-Allow-Origin: *");

    $cn = new PDO("mysql:host=mysql-uwil.alwaysdata.net;dbname=uwil_eatoo", "uwil_1227", "Eatoo2025");


    //$cn = new PDO("mysql:host=localhost;dbname=eatoo_db", "root", "");
    

?>