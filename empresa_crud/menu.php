<?php
// $base define o caminho até a raiz do projeto ('' na raiz, '../' dentro de funcionario/)
$base = $base ?? '';
?>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container">
        <a class="navbar-brand fw-bold" href="<?= $base ?>index.php">Empresa</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#menuPrincipal"
                aria-controls="menuPrincipal" aria-expanded="false" aria-label="Abrir menu">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="menuPrincipal">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<?= $base ?>index.php">Início</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Funcionários
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="<?= $base ?>funcionario/adicionar.php">Adicionar</a></li>
                        <li><a class="dropdown-item" href="<?= $base ?>funcionario/listar.php">Listar</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
