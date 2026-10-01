<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tabuada</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1 align="center">Tabuada</h1>
    <hr>
    <?php
    $numero = (int) $_POST['numero'];
    echo "<table align='center' border='1'>";
    // for ($i=0; $i < 10; $i++) {
    //     $r = $numero * $i;
    //     echo "<tr>";
    //     echo "<td> $numero X $i </td>";
    //     echo "<td> $r </td>";
    //     echo "</tr>";
    // }

    $i = 0;
    while ($i < 10) {
        $r = $numero * $i;
        echo "<tr>";
        echo "<td> $numero X $i </td>";
        echo "<td> $r </td>";
        echo "</tr>";
        $i++;
    }
    echo "</table>";
    ?>
    <p align="center"><a href="index.html">Voltar</a></p>
</body>
</html>

