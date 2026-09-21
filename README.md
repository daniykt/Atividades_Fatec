# Aula 7 — App de Checkout e Navegação no Flutter

Atividade da disciplina **Programação para Dispositivos Móveis I** — FATEC Matão, semestre 2026/2.
Professor: Diego Menegassi.

App multitela em Flutter com gerenciamento de estado local (`setState`) e navegação entre telas (`Navigator.push` / `Navigator.pop`), incluindo os três níveis de desafio propostos no roteiro.

## Estrutura

- `lib/main.dart` — `TelaContador` (`StatefulWidget`) com seleção de quantidade, botão de zerar e navegação para o resumo.
- `lib/tela_resumo.dart` — `TelaResumo` (`StatelessWidget`) exibindo item, quantidade e valor total.

## Desafios implementados

- **Nível 1:** botão *Zerar Contador* que redefine a quantidade para 1.
- **Nível 2:** cálculo do valor total a partir do preço unitário (R$ 150,00), exibido na `TelaResumo`.
- **Nível 3:** `Navigator.pop(context, true)` na confirmação, com `SnackBar` de "Pedido Confirmado com Sucesso!" na `TelaContador`.

## Como executar

```bash
flutter pub get
flutter run
```

## Evidências

Prints da execução na pasta raiz do repositório:

- `print1.png` — alteração de quantidade na `TelaContador`.
- `print2.png` — `TelaResumo` exibindo os dados recebidos.

O histórico de commits semânticos pode ser conferido diretamente no GitHub.