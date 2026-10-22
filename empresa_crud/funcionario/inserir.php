<?php
require '../conexao.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: adicionar.php');
    exit;
}

$nome          = trim($_POST['nome'] ?? '');
$email         = trim($_POST['email'] ?? '');
$telefone      = trim($_POST['telefone'] ?? '');
$cargo         = trim($_POST['cargo'] ?? '');
$salario       = (float) str_replace(',', '.', $_POST['salario'] ?? '0');
$data_admissao = $_POST['data_admissao'] ?? '';

$sql = 'INSERT INTO funcionario (nome, email, telefone, cargo, salario, data_admissao)
        VALUES (?, ?, ?, ?, ?, ?)';

$stmt = $conexao->prepare($sql);
$stmt->bind_param('ssssds', $nome, $email, $telefone, $cargo, $salario, $data_admissao);
$stmt->execute();

$stmt->close();
$conexao->close();

header('Location: listar.php?msg=inserido');
exit;
