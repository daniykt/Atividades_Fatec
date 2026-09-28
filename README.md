# Aula 8 — Listas Dinâmicas & Arquitetura Modular

Atividade da disciplina **Programação para Dispositivos Móveis I** — FATEC Matão, semestre 2026/2.
Professor: Diego Menegassi.

App Flutter de catálogo de produtos com arquitetura modular e renderização otimizada de listas via `ListView.builder`.

## Estrutura do projeto

```
lib/
├── models/
│   └── produto.dart              # Classe de dados imutável
├── widgets/
│   └── produto_card.dart         # Card reutilizável de item
├── screens/
│   ├── catalogo_screen.dart      # Tela principal com a lista
│   └── detalhes_produto_screen.dart  # Tela de detalhes do produto
└── main.dart                     # Configuração do MaterialApp
```

## O que foi implementado

**Base do roteiro:**
- Modelo `Produto` com atributos `final` e construtor `const`.
- Widget `ProdutoCard` reutilizável usando `Card` + `ListTile` + `CircleAvatar`.
- `CatalogoScreen` com `ListView.builder` para renderização sob demanda.
- Material Design 3 com paleta gerada por `ColorScheme.fromSeed`.

**Desafios:**
- **Nível 1:** `FloatingActionButton` que adiciona novos produtos à lista com `setState()`.
- **Nível 2:** `Dismissible` envolvendo cada card, permitindo remover itens com *swipe* da direita para a esquerda.
- **Nível 3:** `DetalhesProdutoScreen` acessada ao tocar em um card, recebendo a instância de `Produto` via construtor.

## Como executar

```bash
flutter pub get
flutter run
```