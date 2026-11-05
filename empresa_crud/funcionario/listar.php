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

            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Nome</th>
                            <th>Cargo</th>
                            <th>Salário</th>
                            <th class="text-end">Operação</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php while ($linha = mysqli_fetch_array($resposta)) { ?>
                            <tr>
                                <td><?php echo $linha["nome"]; ?></td>
                                <td><?php echo $linha["cargo"]; ?></td>
                                <td><?php echo $linha["salario"]; ?></td>
                                <td class="text-end text-nowrap">
                                    <a href="editar.php?id=<?php echo $linha["id"]; ?>" class="btn btn-sm btn-warning">Editar</a>
                                    <a href="remover.php?id=<?php echo $linha["id"]; ?>" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Deseja remover este funcionário?')">Remover</a>
                                </td>
                            </tr>
                        <?php } ?>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
<?php
    //montar o comando SQL
    $sql = "select * from funcionario";

    //conectar com o BD
    require_once("../conexao.php");

    //executar o comando
    $resposta = mysqli_query($conexao, $sql);
?>
