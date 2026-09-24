<?php
// Regras de desconto da Farmácia Parecetaloka

const DESCONTO_FAIXA = [
    'ate50'   => 0,  // Idade até 50: sem desconto
    '51a69'   => 5,  // Idade entre 51 e 70: 5%
    '70mais'  => 7,  // Idade >= 70: 7%
];

const DESCONTO_FIDELIDADE = 5; // Cartão fidelidade: mais 5%

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
,