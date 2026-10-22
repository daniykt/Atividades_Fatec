<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Empresa - Adicionar Funcionário</title>
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
            <h2 class="mb-4">Adicionar Funcionário</h2>

            <form action="inserir.php" method="post">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" maxlength="100" required>
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" class="form-control" id="email" name="email" maxlength="100" required>
                    </div>
                    <div class="col-md-4">
                        <label for="telefone" class="form-label">Telefone</label>
                        <input type="text" class="form-control" id="telefone" name="telefone" maxlength="20">
                    </div>
                    <div class="col-md-4">
                        <label for="cargo" class="form-label">Cargo</label>
                        <input type="text" class="form-control" id="cargo" name="cargo" maxlength="50" required>
                    </div>
                    <div class="col-md-4">
                        <label for="salario" class="form-label">Salário (R$)</label>
                        <input type="number" class="form-control" id="salario" name="salario" step="0.01" min="0" required>
                    </div>
                    <div class="col-md-4">
                        <label for="data_admissao" class="form-label">Data de admissão</label>
                        <input type="date" class="form-control" id="data_admissao" name="data_admissao" required>
                    </div>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">Salvar</button>
                    <a href="listar.php" class="btn btn-secondary">Cancelar</a>
                </div>
            </form>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
