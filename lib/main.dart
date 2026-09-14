import 'package:flutter/material.dart';
import 'models/produto.dart';

void main() {
  runApp(const AppCatalogo());
}

class AppCatalogo extends StatelessWidget {
  const AppCatalogo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo Mobile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const CatalogoPage(),
    );
  }
}

class CatalogoPage extends StatefulWidget {
  const CatalogoPage({super.key});

  @override
  State<CatalogoPage> createState() => _CatalogoPageState();
}

class _CatalogoPageState extends State<CatalogoPage> {
  // JSON simulado do endpoint de catálogo.
  static const Map<String, dynamic> _jsonSimulado = {
    'nome_produto': 'Smartphone Galaxy S24',
    'categoria': 'Mobile',
    'preco': 4599.90,
    'quantidade_estoque': 12,
    'disponivel': true,
    'tags': ['android', '5g', 'snapdragon'],
  };

  late Produto _produto;

  @override
  void initState() {
    super.initState();
    _produto = Produto.fromJson(_jsonSimulado);
  }

  void _recarregar() {
    setState(() {
      _produto = Produto.fromJson(_jsonSimulado);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Catálogo recarregado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final precoFormatado =
        'R\$ ${_produto.preco.toStringAsFixed(2).replaceAll('.', ',')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Mobile'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.primaryContainer,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recarregar',
            onPressed: _recarregar,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _produto.nomeProduto,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Categoria: ${_produto.categoria}',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 16),
                Text(
                  precoFormatado,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Icon(
                      _produto.disponivel
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: _produto.disponivel
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _produto.disponivel ? 'Disponível' : 'Indisponível',
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Estoque: ${_produto.quantidadeEstoque} unidades',
                  style: theme.textTheme.bodyLarge,
                ),
                if (_produto.temEstoqueCritico) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.red.shade700,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Estoque crítico! Menos de 5 unidades disponíveis.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.red.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  'Tags',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _produto.tags
                      .map(
                        (tag) => Chip(
                          label: Text(tag),
                          backgroundColor:
                              theme.colorScheme.secondaryContainer,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _recarregar,
        tooltip: 'Atualizar catálogo',
        child: const Icon(Icons.sync),
      ),
    );
  }
}
