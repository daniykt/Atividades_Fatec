# app_cartao_perfil

Atividade prática da **Aula 5 — Do Código à Tela com Flutter** da disciplina Programação para Dispositivos Móveis I (ILP038), cursada no 4º semestre do curso de Desenvolvimento de Software Multiplataforma na FATEC Matão.

**Aluno:** Danilo
**Professor:** Diego Menegassi

---

## O Desafio do Arquiteto

Reproduzir um **cartão de perfil** aplicando as leis espaciais do Flutter (`Container`, `Row`, `Column`, `SizedBox`, `Icon`, `Text`) e completar os três níveis do desafio proposto no slide "Seu Turno: O Desafio do Arquiteto".

### Nível Base — Reprodução do cartão

Estrutura em camadas conforme o modelo apresentado em aula:

- **Container** com `margin: EdgeInsets.all(16)`, `padding: EdgeInsets.all(24)`, fundo `Colors.blueGrey[900]` e `borderRadius: BorderRadius.circular(16)`.
- **Row** enfileira o ícone e a coluna de textos, com `SizedBox(width: 16)` entre eles.
- **Column** empilha `Nome`, `Título Profissional` e `Descrição`.
- **Icon** `Icons.person` cyan, `size: 48`.
- Tipografia: nome em branco, negrito, 20pt; título em cinza; descrição em branco suave.

### Nível Evolução — Segundo cartão

Um segundo cartão foi adicionado abaixo do primeiro. Ambos ficam encapsulados em uma `Column` externa dentro de um `SingleChildScrollView`, com `SizedBox` verticais para separação — exatamente como a dica do slide sugere.

### Nível Mestre — Provocando e resolvendo o Overflow

O segundo cartão usa **intencionalmente** um título profissional gigantesco:

> "Desenvolvedora Full-Stack Sênior Especialista em Arquitetura de Microsserviços na Nuvem"

Sem tratamento, esse texto estouraria a largura do `Row` e o Flutter mostraria a listra amarela e preta de *Overflow*. A resolução foi envolver a `Column` interna em um widget **`Expanded`**, que instrui o Flutter a ocupar o espaço horizontal restante e quebrar o texto em várias linhas automaticamente.

---

## Estrutura do projeto

```
app_cartao_perfil/
├── lib/
│   └── main.dart          # AppCartaoPerfil + PerfilPage + CartaoPerfil
├── screenshots/           # Capturas de tela do app em execução
├── pubspec.yaml
└── README.md
```

O widget `CartaoPerfil` foi extraído como componente reutilizável, recebendo `nome`, `titulo` e `descricao` como parâmetros nomeados obrigatórios — reforçando os conceitos de imutabilidade e null safety trabalhados na Aula 4.

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
