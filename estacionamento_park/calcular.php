<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estacionamento Park Fácil</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="estrelas"></div>
    <div class="planeta"></div>

    <main class="painel">
        <h1>🚀 Estacionamento Park Fácil</h1>
        <p class="subtitulo">Resultado do cálculo</p>

        <?php
        $horas = $_POST['horas'];
        $veiculo = $_POST['veiculo'];

        if (isset($_POST['lavagem'])) {
            $lavagem = "Sim";
        } else {
            $lavagem = "Não";
        }
        if($veiculo=="0")
        {
            $primeira=10;
            $adicional=6;
        }
        else
        {
            {$primeira=6; $adicional=3;}
        }
        $total = $primeira;
        for ($h=2;$h<=$horas;$h++)
        {
            $total +=$adicional;
        }
        if($total>50)
        {
            $total = 50;
        }
        if($lavagem=="Sim")
        {
            $total +=20;
        }
        echo "Total à pagar: R$ " .$total;
        echo "<br>";
        echo "<a class='voltar' href='index.html'>⬅ Voltar</a>";
        ?>
    </main>
</body>
</html>
