// ===== Estacionamento Park Fácil: animações e interações =====
//
// Bibliotecas open source usadas (carregadas pelo CDN no final do HTML):
//   GSAP + SplitText + ScrambleText -> entrada da página, letras do título, textos "decodificando"
//   anime.js                        -> órbitas desenhadas no fundo, satélite andando, pulsos de radar
//   Vanilla-tilt                    -> cartões que inclinam em 3D com brilho
//   CountUp.js                      -> total subindo até o valor final (só no resultado)
//   canvas-confetti                 -> chuva de estrelas no resultado
//
// Se alguma biblioteca não carregar, a página continua funcionando sem aquela animação.
// Quem ativou "reduzir movimento" no sistema vê a página sem as animações.

const raiz = document.documentElement;
const reduzirMovimento = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
const temGsap = Boolean(window.gsap && window.SplitText && window.ScrambleTextPlugin) && !reduzirMovimento;

if (temGsap) {
    gsap.registerPlugin(SplitText, ScrambleTextPlugin);
}

// Velocidade das estrelas (o GSAP acelera isso no "salto" ao enviar)
const ceu = { velocidade: 0.35 };

function mostrarPagina() {
    raiz.classList.remove('carregando');
}

// Troca um texto com efeito de "decodificação" (ou troca direto, sem GSAP)
function escrever(elemento, texto, caracteres = 'upperCase') {
    if (!elemento || elemento.textContent === texto) return;
    if (temGsap) {
        gsap.to(elemento, {
            duration: 0.6,
            overwrite: true,
            scrambleText: { text: texto, chars: caracteres, speed: 0.6 }
        });
    } else {
        elemento.textContent = texto;
    }
}


// ---------- 1) Campo de estrelas no canvas ----------
function iniciarEstrelas() {
    const canvas = document.getElementById('estrelas');
    if (!canvas) return;

    const ctx = canvas.getContext('2d');
    const cores = ['#f4e9d8', '#f4e9d8', '#f4e9d8', '#f7b538', '#2ec4b6'];
    const mouse = { x: 0, y: 0 };
    let estrelas = [];
    let largura = 0;
    let altura = 0;

    function redimensionar() {
        const dpr = Math.min(window.devicePixelRatio || 1, 2);
        largura = window.innerWidth;
        altura = window.innerHeight;
        canvas.width = largura * dpr;
        canvas.height = altura * dpr;
        ctx.setTransform(dpr, 0, 0, dpr, 0, 0);

        // z = profundidade: estrelas "perto" são maiores, mais claras e mais rápidas
        const quantidade = Math.round((largura * altura) / 5000);
        estrelas = Array.from({ length: quantidade }, () => ({
            x: Math.random() * largura,
            y: Math.random() * altura,
            z: Math.random() * 0.9 + 0.1,
            cor: cores[Math.floor(Math.random() * cores.length)],
            fase: Math.random() * Math.PI * 2
        }));

        if (reduzirMovimento) desenhar(0);
    }

    function desenhar(tempo) {
        ctx.clearRect(0, 0, largura, altura);

        for (const e of estrelas) {
            e.x -= ceu.velocidade * e.z;
            if (e.x < -80) {
                e.x = largura + 10;
                e.y = Math.random() * altura;
            }

            // parallax: estrelas próximas seguem mais o mouse
            const px = e.x + mouse.x * e.z * 24;
            const py = e.y + mouse.y * e.z * 24;
            const brilho = 0.5 + 0.5 * Math.sin(tempo / 700 + e.fase);
            const rastro = Math.max(e.z * 2.2, ceu.velocidade * e.z * 3);

            ctx.globalAlpha = (0.25 + 0.75 * e.z) * (0.6 + 0.4 * brilho);
            ctx.fillStyle = e.cor;
            ctx.fillRect(px, py, rastro, Math.max(1, e.z * 1.8));
        }
        ctx.globalAlpha = 1;

        if (!reduzirMovimento) requestAnimationFrame(desenhar);
    }

    redimensionar();
    window.addEventListener('resize', redimensionar);
    window.addEventListener('pointermove', (evento) => {
        mouse.x = evento.clientX / largura - 0.5;
        mouse.y = evento.clientY / altura - 0.5;
    });
    if (!reduzirMovimento) requestAnimationFrame(desenhar);
}


// ---------- 2) Relógio "T+" da missão (continua contando na página de resultado) ----------
function iniciarRelogio() {
    const relogio = document.getElementById('relogio');
    if (!relogio) return;

    let inicio = Date.now();
    try {
        inicio = Number(sessionStorage.getItem('inicioMissao')) || inicio;
        sessionStorage.setItem('inicioMissao', inicio);
    } catch (e) {}

    const dois = (n) => String(n).padStart(2, '0');

    function atualizar() {
        const s = Math.floor((Date.now() - inicio) / 1000);
        relogio.textContent = `T+${dois(Math.floor(s / 3600))}:${dois(Math.floor(s / 60) % 60)}:${dois(s % 60)}`;
    }

    atualizar();
    setInterval(atualizar, 1000);
}


// ---------- 3) Órbitas do fundo com anime.js ----------
function animarOrbitas() {
    if (!window.anime || reduzirMovimento) return;
    const { animate, svg, stagger } = anime;

    // "Desenha" as linhas das órbitas e da trajetória, uma depois da outra
    animate(svg.createDrawable('.desenhar'), {
        draw: ['0 0', '0 1'],
        duration: 2600,
        delay: stagger(250, { start: 300 }),
        ease: 'inOutQuad'
    });

    animate('.orbita--tracejada', { opacity: [0, 1], duration: 2600, ease: 'inOutQuad' });

    // Satélite percorrendo a órbita sem parar
    animate('.satelite', {
        ...svg.createMotionPath('#caminho-satelite'),
        duration: 18000,
        loop: true,
        ease: 'linear'
    });

    // Ondas de radar saindo do farol
    animate('.pulso', {
        r: [4, 46],
        opacity: [0.7, 0],
        duration: 2600,
        delay: stagger(870),
        loop: true,
        ease: 'outQuad'
    });

    // Planeta flutuando devagar
    animate('.planeta-svg', {
        translateY: [-8, 8],
        duration: 6000,
        loop: true,
        alternate: true,
        ease: 'inOutSine'
    });
}


// ---------- 4) Formulário: contador, manifesto, validação e envio ----------
function iniciarFormulario() {
    const formulario = document.getElementById('formulario');
    if (!formulario) return;

    // Usamos nossas próprias mensagens de erro no lugar das do navegador
    formulario.noValidate = true;

    const horas = formulario.elements.horas;
    const lavagem = formulario.elements.lavagem;
    const veiculos = formulario.querySelectorAll('input[name="veiculo"]');
    const botao = formulario.querySelector('.botao--principal');
    const botaoTexto = botao.querySelector('.botao-texto');
    const barra = document.getElementById('prontidao-barra');
    const textoPronto = document.getElementById('prontidao-texto');
    const infoLavagem = document.getElementById('lavagem-info');
    const manifesto = {
        horas: document.getElementById('m-horas'),
        veiculo: document.getElementById('m-veiculo'),
        lavagem: document.getElementById('m-lavagem')
    };
    const nomes = { carro: 'Carro', moto: 'Moto' };

    function veiculoEscolhido() {
        const marcado = formulario.querySelector('input[name="veiculo"]:checked');
        return marcado ? marcado.value : '';
    }

    function horasValidas() {
        const n = Number(horas.value);
        return horas.value !== '' && Number.isInteger(n) && n >= 1;
    }

    function mostrarErro(campo, mensagem) {
        const caixa = document.getElementById(campo + '-erro');
        const bloco = caixa.closest('.campo');
        bloco.classList.add('invalido');
        caixa.textContent = mensagem;
        if (campo === 'horas') horas.setAttribute('aria-invalid', 'true');
        if (temGsap) gsap.fromTo(bloco, { x: -10 }, { x: 0, duration: 0.6, ease: 'elastic.out(1, 0.3)' });
    }

    function limparErro(campo) {
        const caixa = document.getElementById(campo + '-erro');
        caixa.closest('.campo').classList.remove('invalido');
        caixa.textContent = '';
        if (campo === 'horas') horas.removeAttribute('aria-invalid');
    }

    // Atualiza o resumo do lado direito e o checklist
    function atualizarManifesto() {
        const veiculo = veiculoEscolhido();
        const okHoras = horasValidas();
        const okVeiculo = Boolean(veiculo);

        escrever(manifesto.horas, okHoras ? `${Number(horas.value)} h` : '—', '0123456789');
        escrever(manifesto.veiculo, okVeiculo ? nomes[veiculo] : '—');
        escrever(manifesto.lavagem, lavagem.checked ? 'Sim' : 'Não');
        escrever(infoLavagem, lavagem.checked ? 'Módulo ativado' : 'Módulo de limpeza externa', 'lowerCase');

        document.querySelector('[data-check="horas"]').classList.toggle('ok', okHoras);
        document.querySelector('[data-check="veiculo"]').classList.toggle('ok', okVeiculo);

        const progresso = (Number(okHoras) + Number(okVeiculo)) / 2;
        if (temGsap) {
            gsap.to(barra, { scaleX: progresso, duration: 0.6, ease: 'power3.out' });
        } else {
            barra.style.transform = `scaleX(${progresso})`;
        }
        textoPronto.textContent = Math.round(progresso * 100) + '%';
        botao.classList.toggle('pronto', progresso === 1);

        if (okHoras) limparErro('horas');
        if (okVeiculo) limparErro('veiculo');
    }

    // Botões de - e + das horas
    formulario.querySelectorAll('[data-passo]').forEach((botaoPasso) => {
        botaoPasso.addEventListener('click', () => {
            const passo = Number(botaoPasso.dataset.passo);
            const atual = parseInt(horas.value, 10) || 0;
            horas.value = Math.max(1, atual + passo);
            atualizarManifesto();
            if (temGsap) {
                gsap.fromTo(horas, { y: passo > 0 ? 12 : -12, opacity: 0.3 },
                    { y: 0, opacity: 1, duration: 0.4, ease: 'back.out(3)' });
            }
        });
    });

    horas.addEventListener('input', atualizarManifesto);
    lavagem.addEventListener('change', atualizarManifesto);

    veiculos.forEach((opcao) => {
        opcao.addEventListener('change', () => {
            atualizarManifesto();
            if (temGsap) {
                const marcador = opcao.closest('.veiculo').querySelector('.veiculo-check');
                gsap.fromTo(marcador, { scale: 0.3 }, { scale: 1, duration: 0.8, ease: 'elastic.out(1, 0.4)' });
            }
        });
    });

    // Limpar: o navegador apaga os campos logo depois do evento, por isso o setTimeout
    formulario.addEventListener('reset', () => {
        setTimeout(() => {
            limparErro('horas');
            limparErro('veiculo');
            atualizarManifesto();
            if (temGsap) {
                gsap.fromTo('.campo', { opacity: 0.4 }, { opacity: 1, duration: 0.5, stagger: 0.06 });
            }
        }, 0);
    });

    // Passar o mouse no botão "decodifica" o texto
    botao.addEventListener('mouseenter', () => {
        if (temGsap && !enviando) {
            gsap.to(botaoTexto, { duration: 0.5, scrambleText: { text: 'Calcular', chars: 'upperCase' } });
        }
    });

    // Calcular: valida, guarda o resumo e faz o "salto" antes de enviar
    let enviando = false;
    formulario.addEventListener('submit', (evento) => {
        if (enviando) {
            evento.preventDefault();
            return;
        }

        const erros = [];
        if (!horasValidas()) erros.push(['horas', 'Informe um número inteiro de horas (mínimo 1).', horas]);
        if (!veiculoEscolhido()) erros.push(['veiculo', 'Escolha o tipo de veículo.', veiculos[0]]);

        if (erros.length > 0) {
            evento.preventDefault();
            erros.forEach(([campo, mensagem]) => mostrarErro(campo, mensagem));
            erros[0][2].focus();
            return;
        }

        // Guarda o que foi escolhido para mostrar no recibo da próxima página
        try {
            sessionStorage.setItem('manifesto', JSON.stringify({
                horas: Number(horas.value),
                veiculo: nomes[veiculoEscolhido()],
                lavagem: lavagem.checked ? 'Sim' : 'Não'
            }));
        } catch (e) {}

        if (!temGsap) return; // sem GSAP o formulário é enviado na hora

        evento.preventDefault();
        enviando = true;
        gsap.timeline({ onComplete: () => formulario.submit() })
            .to(botaoTexto, { duration: 0.6, scrambleText: { text: 'Transmitindo', chars: '01' } }, 0)
            .to('.botao-progresso', { scaleX: 1, duration: 1, ease: 'power2.inOut' }, 0)
            .to(ceu, { velocidade: 70, duration: 1.2, ease: 'power3.in' }, 0.2)
            .to('.console', { autoAlpha: 0, scale: 0.97, y: -24, filter: 'blur(8px)', duration: 0.5, ease: 'power2.in' }, 1)
            .to('.telemetria, .rodape', { autoAlpha: 0, duration: 0.4 }, 1);
    });

    // Se voltar pelo botão do navegador, recarrega para não ficar com a tela "sumida"
    window.addEventListener('pageshow', (evento) => {
        if (evento.persisted) window.location.reload();
    });

    atualizarManifesto();
}


// ---------- 5) Página de resultado: monta o recibo com o total do PHP ----------
function montarRelatorio() {
    const resultado = document.querySelector('.resultado');
    const recibo = document.querySelector('.recibo');
    if (!resultado || !recibo) return null;

    // Procura o valor no texto que o PHP escreveu: "Total à pagar: R$ 16"
    const achado = resultado.textContent.match(/R\$\s*([\d.,]+)/);
    if (!achado) return null;

    const bruto = achado[1];
    const total = parseFloat(bruto.includes(',') ? bruto.replace(/\./g, '').replace(',', '.') : bruto);
    if (Number.isNaN(total)) return null;

    resultado.hidden = true;
    recibo.hidden = false;

    // Linhas do recibo com o que foi escolhido na página anterior
    const lista = document.getElementById('recibo-lista');
    let dados = null;
    try {
        dados = JSON.parse(sessionStorage.getItem('manifesto'));
    } catch (e) {}

    if (dados) {
        [['Horas', dados.horas + ' h'], ['Veículo', dados.veiculo], ['Lavagem', dados.lavagem]]
            .forEach(([rotulo, valor]) => {
                const linha = document.createElement('div');
                const dt = document.createElement('dt');
                const dd = document.createElement('dd');
                dt.textContent = rotulo;
                dd.textContent = valor;
                linha.append(dt, dd);
                lista.append(linha);
            });
    } else {
        lista.hidden = true;
    }

    const formatar = (n) => n.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' });
    const alvo = document.getElementById('total');
    const vaiContar = Boolean(window.countUp) && !reduzirMovimento;

    // Leitores de tela leem o valor final de uma vez, sem a contagem
    document.getElementById('total-leitor').textContent = formatar(total);
    alvo.textContent = formatar(vaiContar ? 0 : total);

    return { total, alvo, formatar, vaiContar };
}

function chuvaDeEstrelas() {
    if (!window.confetti) return;
    const base = {
        shapes: ['star'],
        colors: ['#f7b538', '#ff6b35', '#e8506a', '#2ec4b6', '#f4e9d8'],
        disableForReducedMotion: true,
        gravity: 0.6,
        ticks: 240,
        scalar: 1.1
    };
    confetti({ ...base, particleCount: 70, spread: 75, startVelocity: 38, origin: { x: 0.5, y: 0.45 } });
    setTimeout(() => {
        confetti({ ...base, particleCount: 40, angle: 60, spread: 55, origin: { x: 0, y: 0.75 } });
        confetti({ ...base, particleCount: 40, angle: 120, spread: 55, origin: { x: 1, y: 0.75 } });
    }, 250);
}

function celebrar(relatorio) {
    if (!relatorio) return;

    if (relatorio.vaiContar) {
        const contador = new countUp.CountUp(relatorio.alvo, relatorio.total, {
            duration: 2.2,
            decimalPlaces: 2,
            formattingFn: relatorio.formatar
        });
        if (!contador.error) {
            contador.start(chuvaDeEstrelas);
        } else {
            relatorio.alvo.textContent = relatorio.formatar(relatorio.total);
        }
    } else {
        chuvaDeEstrelas();
    }

    // Carimbo "Aprovado" batendo no recibo quando a contagem termina
    if (temGsap) {
        gsap.from('.carimbo', { scale: 2.6, rotation: -40, autoAlpha: 0, duration: 0.7, delay: 2, ease: 'back.out(1.7)' });
    }
}


// ---------- 6) Cartões que inclinam em 3D (Vanilla-tilt) ----------
function iniciarTilt() {
    const temMouse = window.matchMedia('(hover: hover)').matches;
    if (!window.VanillaTilt || reduzirMovimento || !temMouse) return;

    const alvos = document.querySelectorAll('.veiculo, .recibo:not([hidden])');
    if (alvos.length === 0) return;

    VanillaTilt.init(alvos, {
        max: 7,
        speed: 500,
        perspective: 900,
        scale: 1.02,
        glare: true,
        'max-glare': 0.18,
        gyroscope: false
    });
}


// ---------- 7) Entrada da página (GSAP + SplitText + ScrambleText) ----------
function animarEntrada(aoTerminar) {
    if (!temGsap) {
        mostrarPagina();
        aoTerminar();
        return;
    }

    const lista = gsap.utils.toArray;

    // Separa "Park Fácil" em letras para animar uma a uma
    const titulo = SplitText.create('.titulo-nome', { type: 'chars', charsClass: 'letra' });

    const tl = gsap.timeline({ defaults: { ease: 'power3.out' }, onComplete: aoTerminar });

    // Só anima o que existe na página (o index e o resultado têm partes diferentes)
    function entrar(seletor, de, posicao) {
        const elementos = lista(seletor);
        if (elementos.length > 0) tl.from(elementos, de, posicao);
    }

    entrar('.telemetria', { y: -30, autoAlpha: 0, duration: 0.7 });
    tl.fromTo(lista('.console'),
        { clipPath: 'inset(0% 0% 100% 0%)' },
        { clipPath: 'inset(0% 0% 0% 0%)', duration: 1.1, ease: 'expo.inOut', clearProps: 'clipPath' }, '-=0.3');
    entrar('.console-faixa', { scaleX: 0, transformOrigin: 'left center', duration: 0.8, ease: 'expo.out' }, '-=0.5');
    entrar('.sobretitulo, .titulo-sobre', { autoAlpha: 0, y: 12, stagger: 0.08, duration: 0.5 }, '-=0.4');
    entrar(titulo.chars, { yPercent: 80, rotateX: -90, autoAlpha: 0, stagger: 0.035, duration: 0.7, ease: 'back.out(2)' }, '-=0.3');
    entrar('.subtitulo', { autoAlpha: 0, y: 10, duration: 0.5 }, '-=0.4');
    entrar('.campo, #formulario .acoes, .recibo', { autoAlpha: 0, y: 24, stagger: 0.1, duration: 0.6 }, '-=0.3');
    entrar('.manifesto > *', { autoAlpha: 0, x: 20, stagger: 0.08, duration: 0.5 }, '<0.1');
    entrar('.rodape', { autoAlpha: 0, duration: 0.5 }, '-=0.2');

    // Números 01, 02, 03 "decodificando"
    lista('.num').forEach((numero, i) => {
        const final = numero.textContent;
        numero.textContent = '00';
        tl.to(numero, { duration: 0.8, scrambleText: { text: final, chars: '0123456789' } }, 1.3 + i * 0.12);
    });

    mostrarPagina();
}

// Status da telemetria trocando de mensagem de tempos em tempos
function ciclarStatus() {
    const status = document.getElementById('status');
    if (!status || !status.dataset.ciclo || !temGsap) return;

    const mensagens = status.dataset.ciclo.split('|');
    let atual = 0;
    setInterval(() => {
        atual = (atual + 1) % mensagens.length;
        escrever(status, mensagens[atual]);
    }, 4500);
}


// ---------- Começa tudo ----------
iniciarEstrelas();
iniciarRelogio();
animarOrbitas();
iniciarFormulario();
const relatorio = montarRelatorio();

// O SplitText precisa das fontes carregadas para separar as letras certinho
const fontesProntas = document.fonts ? document.fonts.ready : Promise.resolve();
fontesProntas.then(() => {
    animarEntrada(() => {
        iniciarTilt();
        celebrar(relatorio);
    });
    ciclarStatus();
});
