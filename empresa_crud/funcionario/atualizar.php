<?php
require '../conexao.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header('Location: listar.php');
    exit;
}

$id            = (int) ($_POST['id'] ?? 0);
$nome          = trim($_POST['nome'] ?? '');
$email         = trim($_POST['email'] ?? '');
$telefone      = trim($_POST['telefone'] ?? '');
$cargo         = trim($_POST['cargo'] ?? '');
$salario       = (float) str_replace(',', '.', $_POST['salario'] ?? '0');
$data_admissao = $_POST['data_admissao'] ?? '';

$sql = 'UPDATE funcionario
        SET nome = ?, email = ?, telefone = ?, cargo = ?, salario = ?, data_admissao = ?
        WHERE id = ?';

$stmt = $conexao->prepare($sql);
$stmt->bind_param('ssssdsi', $nome, $email, $telefone, $cargo, $salario, $data_admissao, $id);
$stmt->execute();

$stmt->close();
$conexao->close();

header('Location: listar.php?msg=atualizado');
exit;
