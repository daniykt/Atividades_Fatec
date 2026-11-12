<?php
    //pegar o id que veio pelo link
    $id = $_GET["id"];

    //montar o comando SQL
    $sql = "delete from funcionario where id=$id";

    //conectar com o BD
    include_once("../conexao.php");
    $result=mysqli_query($conexao,$sql);

    //executar o comando
    if ($result) {
        header("location:listar.php");
    }
    else {
         $mysqli_error($conexao);
    }
?>
