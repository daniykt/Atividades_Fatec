<?php
// Regras de desconto da Farmácia Parecetaloka

const DESCONTO_FAIXA = [
    'ate50'   => 0,  // Idade até 50: sem desconto
    '51a69'   => 5,  // Idade entre 51 e 70: 5%
    '70mais'  => 7,  // Idade >= 70: 7%
];

const DESCONTO_FIDELIDADE = 5; // Cartão fidelidade: mais 5%

const MAX_PARCELAS = 6; // Parcelamento de 1x até 6x

function calcularPedido(float $total, string $faixa, bool $fidelidade): array
{
    $descontoFaixa = DESCONTO_FAIXA[$faixa] ?? 0;
    $descontoFidelidade = $fidelidade ? DESCONTO_FIDELIDADE : 0;
    $descontoTotal = $descontoFaixa + $descontoFidelidade;

    $valorDesconto = $total * $descontoTotal / 100;

    return [
        'percentual' => $descontoTotal,
        'desconto'   => $valorDesconto,
        'final'      => $total - $valorDesconto,
    ];
}

// Parcelamento usando for
function parcelarComFor(float $total): array
{
    $parcelas = [];

    for ($quantidade = 1; $quantidade <= MAX_PARCELAS; $quantidade++) {
        $parcelas[$quantidade] = $total / $quantidade;
    }

    return $parcelas;
}

// Parcelamento usando while
function parcelarComWhile(float $total): array
{
    $parcelas = [];
    $quantidade = 1;

    while ($quantidade <= MAX_PARCELAS) {
        $parcelas[$quantidade] = $total / $quantidade;
        $quantidade++;
    }

    return $parcelas;
}
