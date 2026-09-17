<?php
$n1 = (float) $_POST['n1'];
$n2 = (float) $_POST['n2'];

$adicao = $n1 + $n2;
$subtracao = $n1 - $n2;
$multiplicacao = $n1 * $n2;
$divisao = $n1 / $n2;
$modulo = $n1 % $n2;
$potencia = $n1 ** $n2;
$concatenacao=$n1.$n2;

?>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Operações Aritméticas</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>
    <div class="card">
        <h1>Operações Aritméticas</h1>
        <h2>Resultados</h2>
        <hr>
        <h3>
            <?php echo "$n1 + $n2 = $adicao"; ?>
        </h3>
        <h3>
            <?php echo "$n1 - $n2 = $subtracao"; ?>
        </h3>
        <h3>
            <?php echo "$n1 x $n2 = $multiplicacao"; ?>
        </h3>
        <h3>
            <?php echo "$n1 / $n2 = $divisao"; ?>
        </h3>
        <h3>
            <?php echo "$n1 % $n2 = $modulo"; ?>
        </h3>
        <h3>
            <?php echo "$n1 ** $n2 = $potencia"; ?>
        </h3>
    </div>
    
</body>
</html>