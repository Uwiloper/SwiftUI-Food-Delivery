<?php 
    //permitir acceso desde cualquier origen
    header("Access-Control-Allow-Origin: *");

    $cn = new PDO("mysql:host=mysql-uwil.alwaysdata.net;dbname={Database}", "{User}", "{Password}");


    //$cn = new PDO("mysql:host=localhost;dbname=eatoo_db", "root", "");
    

?>
