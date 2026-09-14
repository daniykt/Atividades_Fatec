# app_contador

Atividade prática da **Aula 6 — Interface e Interação: Dando Vida ao Flutter** da disciplina Programação para Dispositivos Móveis I (ILP038), cursada no 4º semestre do curso de Desenvolvimento de Software Multiplataforma na FATEC Matão.

**Aluno:** Danilo
**Professor:** Diego Menegassi

---

## Desafios de Laboratório

Partindo do App Contador base — construído em aula com `Scaffold`, `AppBar`, `Center`, `Column`, `Text`, `FloatingActionButton` e `setState()` — foram implementados os três desafios propostos no slide "Desafios de Laboratório (Mão na Massa)".

### Nível 1 — Básico: Botão de Reset

Adicionado um `OutlinedButton.icon` dentro da `Column` central com ícone `Icons.refresh` e label "Reset". Ao ser pressionado, ele chama o método `_resetar()`, que força a variável de estado `_contador` a voltar a zero:

```dart
void _resetar() {
  setState(() {
    _contador = 0;
  });
}
```

### Nível 2 — Intermediário: Cor dinâmica por paridade

A propriedade `color` do `TextStyle` do número principal é calculada dinamicamente por um getter:

```dart
Color get _corDoNumero {
  if (_contador == 0) return Colors.black87;
  return _contador.isEven ? Colors.blue.shade700 : Colors.red.shade700;
}
```

Assim, números pares aparecem em tons de azul e ímpares em vermelho, atualizando a cada `setState()` disparado pelo FAB ou pelo botão de reset.

### Nível 3 — Avançado: Trava de segurança no limite

A matemática do contador não pode passar de 10. Foi criado um getter `_atingiuLimite` que retorna `true` quando `_contador >= 10`, e o FAB usa essa informação para **passar `null` em `onPressed`**, o que desabilita o botão visualmente (fica acinzentado e não responde ao toque):

```dart
floatingActionButton: FloatingActionButton(
  onPressed: _atingiuLimite ? null : _incrementar,
  child: const Icon(Icons.add),
),
```

Um texto de aviso "Limite máximo atingido!" também aparece em vermelho quando a trava é acionada, dando feedback visual claro ao usuário. O botão de Reset continua ativo, permitindo destravar o FAB voltando o contador a zero.

---

## Estrutura do projeto

```
app_contador/
├── lib/
│   └── main.dart          # AppContador + ContadorPage (StatefulWidget)
├── screenshots/           # Capturas de tela do app em execução
├── pubspec.yaml
└── README.md
```

---

## Conceitos aplicados

- **StatefulWidget** e ciclo de vida com `createState()`.
- **setState()** para notificar o Flutter de mudanças no estado interno.
- **Widgets estruturais:** `Scaffold`, `AppBar`, `Center`, `Column`, `SizedBox`.
- **Widgets visuais:** `Text` com `TextStyle` dinâmico, `Icon`, `OutlinedButton`, `FloatingActionButton`.
- **Material Design 3** com `ColorScheme.fromSeed`.
- **Lógica condicional na UI** — cores, mensagens e estado ativo/inativo do FAB derivados do valor do contador.

---

## Como executar

```bash
flutter pub get
flutter run
```

Durante a execução, `r` no terminal aciona o Hot Reload e `R` o Hot Restart.

---

## Screenshots

### Print 1 — Aplicativo em execução

![print1](screenshots/print1.png)

---

## Tecnologias

- Flutter (SDK 3.19+)
- Dart 3
- Material Design 3
- Git / GitHub
