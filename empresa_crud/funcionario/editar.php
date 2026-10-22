<?php
require '../conexao.php';

$id = (int) ($_GET['id'] ?? 0);

$stmt = $conexao->prepare('SELECT * FROM funcionario WHERE id = ?');
$stmt->bind_param('i', $id);
$stmt->execute();
$f = $stmt->get_result()->fetch_assoc();

$stmt->close();
$conexao->close();

if (!$f) {
    header('Location: listar.php');
    exit;
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empresa - Editar Funcionário</title>
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
            <h2 class="mb-4">Editar Funcionário</h2>

            <form action="atualizar.php" method="post">
                <input type="hidden" name="id" value="<?= $f['id'] ?>">

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" maxlength="100" required
                               value="<?= htmlspecialchars($f['nome']) ?>">
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" class="form-control" id="email" name="email" maxlength="100" required
                               value="<?= htmlspecialchars($f['email']) ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="telefone" class="form-label">Telefone</label>
                        <input type="text" class="form-control" id="telefone" name="telefone" maxlength="20"
                               value="<?= htmlspecialchars($f['telefone']) ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="cargo" class="form-label">Cargo</label>
                        <input type="text" class="form-control" id="cargo" name="cargo" maxlength="50" required
                               value="<?= htmlspecialchars($f['cargo']) ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="salario" class="form-label">Salário (R$)</label>
                        <input type="number" class="form-control" id="salario" name="salario" step="0.01" min="0" required
                               value="<?= $f['salario'] ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="data_admissao" class="form-label">Data de admissão</label>
                        <input type="date" class="form-control" id="data_admissao" name="data_admissao" required
                               value="<?= $f['data_admissao'] ?>">
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">Atualizar</button>
                    <a href="listar.php" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
