<?php
    //este arquivo CONECTA com o BD MYSQL
    //definir as variaveis
    $servidor="localhost";
    $usuario="root";
    $senha="";
    $bd="empresa";
    //charmar o comando para CONECTAR
    $conexao=mysqli_connect($servidor,$usuario,$senha,$bd);
    if ($conexao){
        echo "Conexao realizada com sucesso";
    }
    else{
        echo mysqli_error($conexao);
    }          
?>