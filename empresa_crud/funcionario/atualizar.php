<?php
    //pegar os dados que vieram do formulario de edicao
    $id = $_POST["id"];
    $nome = $_POST["nome"];
    $email = $_POST["email"];
    $telefone = $_POST["telefone"];
    $cargo = $_POST["cargo"];
    $salario = $_POST["salario"];
    $data_admissao = $_POST["data_admissao"];

    //montar o comando SQL
    $sql = "update funcionario set nome='$nome', email='$email', telefone='$telefone',
            cargo='$cargo', salario='$salario', data_admissao='$data_admissao'
            where id=$id";

    //conectar com o BD
    require_once("../conexao.php");

    //executar o comando
    $resposta = mysqli_query($conexao, $sql);
    if ($resposta == true) {
        header("location:listar.php");
    }
    else {
        echo "Erro ao atualizar: " . mysqli_error($conexao);
    }
?>
