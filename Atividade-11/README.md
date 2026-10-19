# Atividade 11 — Fluxo Lista-Detalhe (Master-Detail)

Disciplina: Programação para Dispositivos Móveis I (Flutter) — Prof. Diego Menegassi

Portal de notícias com **duas telas conectadas por navegação**. O feed carrega a lista resumida da API [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) usando **`FutureBuilder`**. Ao tocar em um item, a tela de detalhes recebe o objeto `NoticiaModel` fortemente tipado pelo construtor, sem refazer a requisição da notícia.

## Estrutura de pastas

```
lib/
├── models/
│   └── noticia_model.dart          # Modelo imutável + factory fromJson
├── services/
│   └── noticia_service.dart        # Busca de notícias e comentários (exceções propagam pro FutureBuilder)
├── screens/
│   ├── feed_noticias_screen.dart   # Lista (master) com FutureBuilder
│   └── detalhe_noticia_screen.dart # Detalhes (detail) com favoritar e comentários
└── main.dart                       # MaterialApp (Material 3, seed indigo)
```

## Níveis implementados

- **Básico — Hero Animation:** a miniatura do card no feed e a imagem grande do detalhe compartilham a tag `noticia-{id}`, então a imagem "cresce" na transição. As imagens vêm do [Lorem Picsum](https://picsum.photos), uma por notícia.
- **Intermediário — Favoritar:** botão de coração na AppBar do detalhe. Ao voltar, um `PopScope` devolve o estado com `Navigator.pop(context, favoritado)`. O feed recebe o valor via `await Navigator.push<bool>`, guarda os favoritos em um `Set<int>`, mostra o SnackBar "Adicionado aos favoritos" e exibe um coração ao lado do título.
- **Avançado — Comentários:** a tela de detalhes busca `/posts/{id}/comments` no `initState` e exibe os comentários em um segundo `FutureBuilder`, abaixo do conteúdo.

## Como executar

```bash
cd Atividade-11
flutter pub get
flutter run -d chrome
```

Para rodar os testes do modelo:

```bash
flutter test
```
