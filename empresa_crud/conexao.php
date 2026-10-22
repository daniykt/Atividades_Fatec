<?php
// Configuração padrão do MySQL no XAMPP
$host  = 'localhost';
$user  = 'root';
$senha = '';
$banco = 'empresa';

$conexao = new mysqli($host, $user, $senha, $banco);

if ($conexao->connect_error) {
    die('Erro na conexão com o banco de dados: ' . $conexao->connect_error);
}

$conexao->set_charset('utf8mb4');
