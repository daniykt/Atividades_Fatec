<?php
require '../conexao.php';

$id = (int) ($_GET['id'] ?? 0);

$stmt = $conexao->prepare('DELETE FROM funcionario WHERE id = ?');
$stmt->bind_param('i', $id);
$stmt->execute();

$stmt->close();
$conexao->close();

header('Location: listar.php?msg=removido');
exit;
