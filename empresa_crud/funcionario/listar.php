<?php
require '../conexao.php';

$resultado = $conexao->query('SELECT * FROM funcionario ORDER BY nome');

$mensagens = [
    'inserido'   => 'Funcionário cadastrado com sucesso!',
    'atualizado' => 'Funcionário atualizado com sucesso!',
    'removido'   => 'Funcionário removido com sucesso!',
];
$msg = $mensagens[$_GET['msg'] ?? ''] ?? null;
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empresa - Funcionários</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="../style.css">
</head>
<body>
    <?php
    $base = '../';
    include '../menu.php';
    ?>

    <main class="container">
        <div class="card p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="mb-0">Funcionários</h2>
                <a href="adicionar.php" class="btn btn-primary">+ Adicionar</a>
            </div>

            <?php if ($msg): ?>
                <div class="alert alert-success"><?= $msg ?></div>
            <?php endif; ?>

            <?php if ($resultado->num_rows === 0): ?>
                <p class="text-muted mb-0">Nenhum funcionário cadastrado.</p>
            <?php else: ?>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>ID</th>
                                <th>Nome</th>
                                <th>E-mail</th>
                                <th>Telefone</th>
                                <th>Cargo</th>
                                <th>Salário</th>
                                <th>Admissão</th>
                                <th class="text-end">Ações</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php while ($f = $resultado->fetch_assoc()): ?>
                                <tr>
                                    <td><?= $f['id'] ?></td>
                                    <td><?= htmlspecialchars($f['nome']) ?></td>
                                    <td><?= htmlspecialchars($f['email']) ?></td>
                                    <td><?= htmlspecialchars($f['telefone']) ?></td>
                                    <td><?= htmlspecialchars($f['cargo']) ?></td>
                                    <td>R$ <?= number_format($f['salario'], 2, ',', '.') ?></td>
                                    <td><?= date('d/m/Y', strtotime($f['data_admissao'])) ?></td>
                                    <td class="text-end text-nowrap">
                                        <a href="editar.php?id=<?= $f['id'] ?>" class="btn btn-sm btn-warning">Editar</a>
                                        <a href="remover.php?id=<?= $f['id'] ?>" class="btn btn-sm btn-danger"
                                           onclick="return confirm('Deseja remover este funcionário?')">Remover</a>
                                    </td>
                                </tr>
                            <?php endwhile; ?>
                        </tbody>
                    </table>
                </div>
            <?php endif; ?>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<?php $conexao->close(); ?>
