import 'package:flutter/material.dart';

void main() {
  runApp(const AppContador());
}

class AppContador extends StatelessWidget {
  const AppContador({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const ContadorPage(),
    );
  }
}

class ContadorPage extends StatefulWidget {
  const ContadorPage({super.key});

  @override
  State<ContadorPage> createState() => _ContadorPageState();
}

class _ContadorPageState extends State<ContadorPage> {
  int _contador = 0;

  // Limite máximo do contador (Nível 3 — trava de segurança).
  static const int _limite = 10;

  void _incrementar() {
    setState(() {
      _contador++;
    });
  }

  void _resetar() {
    setState(() {
      _contador = 0;
    });
  }

  /// NÍVEL 2 — Cor dinâmica: pares em azul, ímpares em vermelho.
  Color get _corDoNumero {
    if (_contador == 0) return Colors.black87;
    return _contador.isEven ? Colors.blue.shade700 : Colors.red.shade700;
  }

  /// NÍVEL 3 — Trava de segurança: quando bate no limite,
  /// o FAB recebe `null` em `onPressed`, o que o desabilita visualmente.
  bool get _atingiuLimite => _contador >= _limite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Você pressionou o botão:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            // O Display: Text com TextStyle, cor calculada dinamicamente.
            Text(
              '$_contador',
              style: TextStyle(
                fontSize: 96,
                fontWeight: FontWeight.bold,
                color: _corDoNumero,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _contador == 0
                  ? 'Toque no + para começar'
                  : _atingiuLimite
                      ? 'Limite máximo atingido!'
                      : _contador.isEven
                          ? 'Número par'
                          : 'Número ímpar',
              style: TextStyle(
                fontSize: 16,
                color: _atingiuLimite ? Colors.red.shade700 : Colors.grey,
                fontWeight:
                    _atingiuLimite ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const SizedBox(height: 32),
            // NÍVEL 1 — OutlinedButton de Reset dentro da Column.
            OutlinedButton.icon(
              onPressed: _resetar,
              icon: const Icon(Icons.refresh),
              label: const Text('Reset'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      // NÍVEL 3 — onPressed recebe `null` quando o limite é atingido,
      // desabilitando o FAB visualmente (fica acinzentado).
      floatingActionButton: FloatingActionButton(
        onPressed: _atingiuLimite ? null : _incrementar,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}
