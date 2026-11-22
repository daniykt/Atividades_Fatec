# Atividade 15 — Câmera e Mídia

Disciplina: Programação para Dispositivos Móveis I (Flutter)
Professor: Diego Menegassi

## Tema

App de perfil de usuário com foto escolhida pela câmera ou pela galeria,
usando o pacote [`image_picker`](https://pub.dev/packages/image_picker).

## Estrutura de pastas

```
lib/
├── services/
│   └── media_service.dart   # câmera/galeria (image_picker) e persistência (shared_preferences)
├── screens/
│   ├── perfil_screen.dart            # tela "Perfil do Usuário"
│   └── foto_tela_cheia_screen.dart   # tela cheia com zoom (InteractiveViewer)
└── main.dart
```

## Desafios implementados

- **Básico — Remover foto:** opção "Remover Foto" no `showModalBottomSheet`,
  exibida só quando há foto selecionada, que limpa o `CircleAvatar`.
- **Intermediário — Tela cheia com Hero e zoom:** tocar no avatar (quando há
  foto) abre `FotoTelaCheiaScreen` com `Hero` (mesma tag nas duas telas) e
  `InteractiveViewer` para zoom, sobre fundo preto.
- **Avançado — Persistir a foto:** o caminho da foto é salvo no
  `SharedPreferences` (`key_foto_perfil`) ao escolher uma imagem e removido
  ao tocar em "Remover Foto". No `initState`, a tela carrega o caminho salvo
  e exibe a foto se o arquivo ainda existir, mantendo a foto após reiniciar
  o app.

## Como executar

```bash
cd Atividade-15
flutter pub get
flutter run
```

**Importante:** rode em um dispositivo/emulador Android (ou iOS). No Chrome
a foto não aparece, pois o app usa `dart:io` (`File`) para acessar o arquivo
da imagem, o que não é suportado na web.
