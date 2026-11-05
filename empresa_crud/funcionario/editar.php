<?php
    //pegar o id que veio pelo link
    $id = $_GET["id"];

    //montar o comando SQL
    $sql = "select * from funcionario where id=$id";

    //conectar com o BD
    require_once("../conexao.php");

    //executar o comando e pegar o funcionario
    $resposta = mysqli_query($conexao, $sql);
    $linha = mysqli_fetch_array($resposta);
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
                <input type="hidden" name="id" value="<?php echo $linha["id"]; ?>">

                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="nome" class="form-label">Nome</label>
                        <input type="text" class="form-control" id="nome" name="nome" required
                               value="<?php echo $linha["nome"]; ?>">
                    </div>
                    <div class="col-md-6">
                        <label for="email" class="form-label">E-mail</label>
                        <input type="email" class="form-control" id="email" name="email" required
                               value="<?php echo $linha["email"]; ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="telefone" class="form-label">Telefone</label>
                        <input type="text" class="form-control" id="telefone" name="telefone"
                               value="<?php echo $linha["telefone"]; ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="cargo" class="form-label">Cargo</label>
                        <input type="text" class="form-control" id="cargo" name="cargo" required
                               value="<?php echo $linha["cargo"]; ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="salario" class="form-label">Salário (R$)</label>
                        <input type="number" class="form-control" id="salario" name="salario" step="0.01" min="0" required
                               value="<?php echo $linha["salario"]; ?>">
                    </div>
                    <div class="col-md-4">
                        <label for="data_admissao" class="form-label">Data de admissão</label>
                        <input type="date" class="form-control" id="data_admissao" name="data_admissao" required
                               value="<?php echo $linha["data_admissao"]; ?>">
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
