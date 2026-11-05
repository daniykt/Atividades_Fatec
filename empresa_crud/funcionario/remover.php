<?php
    //pegar o id que veio pelo link
    $id = $_GET["id"];

    //montar o comando SQL
    $sql = "delete from funcionario where id=$id";

    //conectar com o BD
    require_once("../conexao.php");

    //executar o comando
    $resposta = mysqli_query($conexao, $sql);
    if ($resposta == true) {
        header("location:listar.php");
    }
    else {
        echo "Erro ao remover: " . mysqli_error($conexao);
    }
?>
