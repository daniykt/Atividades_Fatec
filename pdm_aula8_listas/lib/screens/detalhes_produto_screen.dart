import 'package:flutter/material.dart';
import '../models/produto.dart';

class DetalhesProdutoScreen extends StatelessWidget {
  final Produto produto;

  const DetalhesProdutoScreen({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Produto'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  produto.icone,
                  style: const TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              produto.nome,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _LinhaInfo(rotulo: 'ID', valor: produto.id),
                    const Divider(),
                    _LinhaInfo(rotulo: 'Categoria', valor: produto.categoria),
                    const Divider(),
                    _LinhaInfo(
                      rotulo: 'Preço',
                      valor: 'R\$ ${produto.preco.toStringAsFixed(2)}',
                      destaque: true,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Voltar ao Catálogo'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinhaInfo extends StatelessWidget {
  final String rotulo;
  final String valor;
  final bool destaque;

  const _LinhaInfo({
    required this.rotulo,
    required this.valor,
    this.destaque = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            rotulo,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            valor,
            style: TextStyle(
              fontSize: 16,
              fontWeight: destaque ? FontWeight.bold : FontWeight.normal,
              color: destaque ? Colors.green : null,
            ),
          ),
        ],
      ),
    );
  }
}