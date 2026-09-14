import 'package:flutter/material.dart';

void main() {
  runApp(const AppCartaoPerfil());
}

class AppCartaoPerfil extends StatelessWidget {
  const AppCartaoPerfil({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cartão de Perfil',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const PerfilPage(),
    );
  }
}

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desafio do Arquiteto'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        // NÍVEL EVOLUÇÃO: Column externa envelopando os dois cartões,
        // com SizedBox para separá-los verticalmente.
        child: Column(
          children: const [
            SizedBox(height: 16),
            CartaoPerfil(
              nome: 'Danilo Silva',
              titulo: 'Desenvolvedor Flutter',
              descricao:
                  'Estudante de DSM na FATEC Matão, apaixonado por front-end e desenvolvimento mobile.',
            ),
            SizedBox(height: 8),
            // NÍVEL MESTRE: subtítulo gigante que provocaria Overflow no Row,
            // resolvido com Expanded envolvendo a Column dos textos.
            CartaoPerfil(
              nome: 'Ana Pereira',
              titulo:
                  'Desenvolvedora Full-Stack Sênior Especialista em Arquitetura de Microsserviços na Nuvem',
              descricao:
                  'Atua há mais de 10 anos com sistemas distribuídos e mentoria de times de engenharia.',
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Cartão de perfil reutilizável — implementa o layout do slide 13
/// (Container → Row → Icon + Column com Nome/Título/Descrição).
class CartaoPerfil extends StatelessWidget {
  final String nome;
  final String titulo;
  final String descricao;

  const CartaoPerfil({
    super.key,
    required this.nome,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    // PASSO 1 — A Fundação: Container com margin, padding, cor e borderRadius.
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.blueGrey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      // PASSO 2 — O Esqueleto: Row com Icon + SizedBox + Column dos textos.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PASSO 3 — Acabamentos: Icon injetando cor e vida.
          const Icon(Icons.person, size: 48, color: Colors.cyan),
          const SizedBox(width: 16),
          // NÍVEL MESTRE: Expanded resolve o Overflow quando o texto é longo.
          // Sem ele, um subtítulo gigante estoura a largura do Row.
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nome,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  descricao,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
