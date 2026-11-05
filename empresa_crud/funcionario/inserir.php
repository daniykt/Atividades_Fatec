<?php
    //pegar os dados que vieram do formulario
    $nome = $_POST["nome"];
    $email = $_POST["email"];
    $telefone = $_POST["telefone"];
    $cargo = $_POST["cargo"];
    $salario = $_POST["salario"];
    $data_admissao = $_POST["data_admissao"];

    //montar o comando SQL
    $sql = "insert into funcionario(nome, email, telefone, cargo, salario, data_admissao)
            values('$nome', '$email', '$telefone', '$cargo', '$salario', '$data_admissao')";

    //conectar com o BD
    require_once("../conexao.php");

    //executar o comando
    $resposta = mysqli_query($conexao, $sql);
    if ($resposta == true) {
        header("location:listar.php");
    }
    else {
        echo "Erro ao inserir: " . mysqli_error($conexao);
    }
?>
