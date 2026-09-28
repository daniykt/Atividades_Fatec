<?php
require 'calculo.php';

$nomes = [
    'ate50'  => 'Até 50 anos',
    '51a69'  => 'De 51 a 69 anos',
    '70mais' => '70 anos ou mais',
];

$resultado = null;
$nome = '';
$total = '';
$faixa = 'ate50';
$fidelidade = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $nome = trim($_POST['nome'] ?? '');
    $total = (float) str_replace(',', '.', $_POST['total'] ?? '0');
    $faixa = $_POST['faixa'] ?? 'ate50';
    $fidelidade = isset($_POST['fidelidade']);

    $resultado = calcularPedido($total, $faixa, $fidelidade);
}

function brl(float $v): string
{
    return 'R$ ' . number_format($v, 2, ',', '.');
}
?>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Farmácia Parecetaloka</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <main class="card">
        <h1>Farmácia Parecetaloka</h1>
        <p class="sub">Cálculo do total do pedido</p>

        <form method="post">
            <label for="nome">Nome do cliente</label>
            <input type="text" id="nome" name="nome" required
                   value="<?= htmlspecialchars($nome) ?>">

            <label for="total">Total do pedido (R$)</label>
            <input type="number" id="total" name="total" step="0.01" min="0" required
                   value="<?= htmlspecialchars((string) $total) ?>">

            <label for="faixa">Faixa etária</label>
            <select id="faixa" name="faixa">
                <?php foreach ($nomes as $valor => $texto): ?>
                    <option value="<?= $valor ?>" <?= $faixa === $valor ? 'selected' : '' ?>>
                        <?= $texto ?>
                    </option>
                <?php endforeach; ?>
            </select>

            <label class="check">
                <input type="checkbox" name="fidelidade" <?= $fidelidade ? 'checked' : '' ?>>
                Pagamento com cartão fidelidade
            </label>

            <button type="submit">Calcular</button>
        </form>

        <?php if ($resultado): ?>
            <section class="resultado">
                <h2>Resumo do pedido</h2>
                <p><strong>Cliente:</strong> <?= htmlspecialchars($nome) ?></p>
                <p><strong>Total do pedido:</strong> <?= brl($total) ?></p>
                <p><strong>Desconto (<?= $resultado['percentual'] ?>%):</strong>
                   - <?= brl($resultado['desconto']) ?></p>
                <p class="final">Total a pagar: <?= brl($resultado['final']) ?></p>
            </section>
        <?php endif; ?>
    </main>
</body>
</html>
