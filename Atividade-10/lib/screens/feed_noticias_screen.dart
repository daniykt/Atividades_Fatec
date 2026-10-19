import 'package:flutter/material.dart';

import '../models/noticia_model.dart';
import '../services/noticia_service.dart';
import 'detalhe_noticia_screen.dart';

class FeedNoticiasScreen extends StatefulWidget {
  const FeedNoticiasScreen({super.key});

  @override
  State<FeedNoticiasScreen> createState() => _FeedNoticiasScreenState();
}

class _FeedNoticiasScreenState extends State<FeedNoticiasScreen> {
  final NoticiaService _service = NoticiaService();

  List<NoticiaModel> _noticias = [];
  bool _carregando = true;
  String? _erro;
  bool _simularErro = false;
  String _filtroBusca = '';

  @override
  void initState() {
    super.initState();
    _carregarFeed();
  }

  Future<void> _carregarFeed() async {
    setState(() {
      _carregando = true;
      _erro = null;
    });

    try {
      final noticias = await _service.buscarNoticias(simularErro: _simularErro);
      if (!mounted) return;
      setState(() {
        _noticias = noticias;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _erro = e.toString().replaceFirst('Exception: ', '');
      });
    } finally {
      if (mounted) {
        setState(() {
          _carregando = false;
        });
      }
    }
  }

  void _alternarSimulacaoErro() {
    setState(() {
      _simularErro = !_simularErro;
    });
    _carregarFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed de Notícias'),
        actions: [
          IconButton(
            icon: Icon(_simularErro ? Icons.bug_report : Icons.check_circle),
            tooltip: _simularErro
                ? 'Desativar simulação de erro'
                : 'Simular erro',
            onPressed: _alternarSimulacaoErro,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Recarregar',
            onPressed: _carregarFeed,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar por título...',
                border: OutlineInputBorder(),
              ),
              onChanged: (valor) {
                setState(() {
                  _filtroBusca = valor;
                });
              },
            ),
          ),
          Expanded(child: _buildConteudo()),
        ],
      ),
    );
  }

  Widget _buildConteudo() {
    if (_carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_erro != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _erro!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: _carregarFeed,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
      );
    }

    final noticiasFiltradas = _noticias
        .where(
          (n) => n.titulo.toLowerCase().contains(_filtroBusca.toLowerCase()),
        )
        .toList();

    if (noticiasFiltradas.isEmpty) {
      return const Center(child: Text('Nenhuma notícia encontrada'));
    }

    return ListView.builder(
      itemCount: noticiasFiltradas.length,
      itemBuilder: (context, index) {
        final noticia = noticiasFiltradas[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: CircleAvatar(child: Text('${noticia.id}')),
            title: Text(
              noticia.titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              noticia.resumo,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetalheNoticiaScreen(noticia: noticia),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
