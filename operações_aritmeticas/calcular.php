<?php
$n1 = (float) $_POST['n1'];
$n2 = (float) $_POST['n2'];

$adicao = $n1 + $n2;
$subtracao = $n1 - $n2;
$multiplicacao = $n1 * $n2;
$potencia = $n1 ** $n2;
$concatenacao=$n1.$n2;

$divisaoValida = $n2 != 0;
if ($divisaoValida == true)
{
    $divisao = $n1 / $n2;
    $modulo = $n1 % $n2;
}

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
        
        <?php 
        if ($divisaoValida == true)
        {
            echo "<h3>$n1 / $n2 = " . number_format($divisao, 2, ',', '.') . "</h3>";
            echo "<h3>$n1 % $n2 = " . number_format($modulo, 2, ',', '.') . "</h3>";
        }
        else
        {
            echo "<h3>Não há divisão por zero!</h3>";
        }
        ?>
        
        <h3>
            <?php echo "$n1 ** $n2 = $potencia"; ?>
        </h3>
        
        <a href="index.php">Voltar</a>
    </div>
    
</body>
</html>