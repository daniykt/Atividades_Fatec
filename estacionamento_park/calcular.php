<!DOCTYPE html>
<html lang="pt-br" class="carregando">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Estacionamento Park Fácil</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;600&family=Righteous&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <script>
        // Avisa o CSS que o JavaScript está ligado.
        // Por segurança, se algo der errado, mostra a página depois de 3 segundos.
        document.documentElement.classList.add('js');
        setTimeout(function () { document.documentElement.classList.remove('carregando'); }, 3000);
    </script>
</head>
<body>
    <!-- ===== Fundo: estrelas, planeta, órbitas e efeito de tela antiga ===== -->
    <canvas class="estrelas" id="estrelas" aria-hidden="true"></canvas>
    <svg class="orbitas" viewBox="0 0 1600 900" preserveAspectRatio="xMaxYMax slice" aria-hidden="true">
        <defs>
            <pattern id="listras" patternUnits="userSpaceOnUse" width="20" height="66">
                <rect y="0" width="20" height="22" fill="#f7b538"/>
                <rect y="22" width="20" height="22" fill="#ff6b35"/>
                <rect y="44" width="20" height="22" fill="#e8506a"/>
            </pattern>
            <radialGradient id="sombra-planeta" cx="0.3" cy="0.3" r="0.85">
                <stop offset="0" stop-color="#0d0a14" stop-opacity="0"/>
                <stop offset="1" stop-color="#0d0a14" stop-opacity="0.6"/>
            </radialGradient>
            <mask id="fendas" maskUnits="userSpaceOnUse" x="1000" y="400" width="700" height="600">
                <rect x="1000" y="400" width="700" height="600" fill="#fff"/>
                <rect x="1000" y="760" width="700" height="12" fill="#000"/>
                <rect x="1000" y="812" width="700" height="18" fill="#000"/>
                <rect x="1000" y="866" width="700" height="26" fill="#000"/>
            </mask>
        </defs>

        <g class="planeta-svg">
            <g mask="url(#fendas)">
                <circle cx="1330" cy="720" r="230" fill="url(#listras)"/>
                <circle cx="1330" cy="720" r="230" fill="url(#sombra-planeta)"/>
            </g>
        </g>

        <g transform="rotate(-12 1330 720)">
            <path class="orbita orbita--tracejada" d="M 670 720 A 660 170 0 1 1 1990 720 A 660 170 0 1 1 670 720"/>
            <path class="orbita desenhar" id="caminho-satelite" d="M 860 720 A 470 110 0 1 1 1800 720 A 470 110 0 1 1 860 720"/>
            <path class="orbita desenhar" d="M 990 720 A 340 74 0 1 1 1670 720 A 340 74 0 1 1 990 720"/>
            <circle class="satelite" r="5"/>
        </g>

        <path class="trajetoria desenhar" d="M 528 186 C 820 170 1040 330 1180 560"/>

        <g class="farol">
            <path class="farol-mira" d="M 502 180 H 512 M 528 180 H 538 M 520 162 V 172 M 520 188 V 198"/>
            <circle class="farol-centro" cx="520" cy="180" r="3"/>
            <circle class="pulso" cx="520" cy="180" r="4"/>
            <circle class="pulso" cx="520" cy="180" r="4"/>
            <circle class="pulso" cx="520" cy="180" r="4"/>
        </g>
    </svg>
    <div class="grade" aria-hidden="true"></div>
    <div class="crt" aria-hidden="true"></div>

    <!-- ===== Barra de telemetria ===== -->
    <header class="telemetria intro">
        <span class="tel-item"><span class="tel-rotulo">Estação</span> <b>PKF-01</b></span>
        <span class="tel-item tel-relogio"><span class="tel-rotulo">Tempo de missão</span> <b id="relogio">T+00:00:00</b></span>
        <span class="tel-item">
            <span class="led" aria-hidden="true"></span>
            <b id="status">Cálculo concluído</b>
        </span>
    </header>

    <!-- ===== Console com o resultado ===== -->
    <main class="console console--relatorio intro">
        <div class="console-faixa" aria-hidden="true"></div>

        <section class="console-corpo">
            <p class="sobretitulo"><span class="codigo">PKF-01</span> Relatório de cobrança</p>
            <h1 class="titulo">
                <span class="titulo-sobre">Estacionamento</span>
                <span class="titulo-nome">Park Fácil</span>
            </h1>

            <!-- Recibo bonito: o app.js preenche com o total que o PHP calculou -->
            <div class="recibo" hidden>
                <span class="carimbo">Aprovado</span>
                <p class="recibo-rotulo">Total a pagar</p>
                <p class="recibo-total"><span id="total" aria-hidden="true"></span><span class="sr-only" id="total-leitor"></span></p>
                <dl class="lista-dados" id="recibo-lista"></dl>
                <div class="acoes">
                    <a class="botao botao--principal" href="index.html"><span class="botao-texto">Voltar</span></a>
                </div>
            </div>

            <!-- Resultado do PHP (fica visível se o JavaScript não rodar) -->
            <div class="resultado">
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
            </div>
        </section>
    </main>

    <footer class="rodape intro">
        <span>Órbita baixa · Setor 7</span>
        <span>Park Fácil · v2.0</span>
    </footer>

    <!-- ===== Bibliotecas de animação (open source) ===== -->
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/SplitText.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/gsap@3.13.0/dist/ScrambleTextPlugin.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/animejs@4.0.2/lib/anime.umd.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/vanilla-tilt@1.8.1/dist/vanilla-tilt.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/countup.js@2.8.0/dist/countUp.umd.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js"></script>
    <script src="app.js"></script>
</body>
</html>
