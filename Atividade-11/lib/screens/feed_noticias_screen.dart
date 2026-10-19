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
  late Future<List<NoticiaModel>> _futureNoticias;
  final Set<int> _favoritos = {};

  @override
  void initState() {
    super.initState();
    _futureNoticias = _service.buscarNoticias();
  }

  Future<void> _abrirDetalhes(NoticiaModel item) async {
    final favoritado = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DetalheNoticiaScreen(
          noticia: item,
          favoritadoInicial: _favoritos.contains(item.id),
        ),
      ),
    );

    if (!mounted || favoritado == null) return;

    if (favoritado && !_favoritos.contains(item.id)) {
      setState(() => _favoritos.add(item.id));
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Adicionado aos favoritos')));
    } else if (!favoritado && _favoritos.contains(item.id)) {
      setState(() => _favoritos.remove(item.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal de Notícias'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<NoticiaModel>>(
        future: _futureNoticias,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          final noticias = snapshot.data ?? [];
          if (noticias.isEmpty) {
            return const Center(child: Text('Nenhuma notícia encontrada.'));
          }

          return ListView.builder(
            itemCount: noticias.length,
            itemBuilder: (context, index) {
              final item = noticias[index];
              final favorito = _favoritos.contains(item.id);

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  leading: Hero(
                    tag: 'noticia-${item.id}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        item.urlImagem,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 56,
                          height: 56,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.image, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    children: [
                      if (favorito) ...[
                        const Icon(Icons.favorite, color: Colors.red, size: 16),
                        const SizedBox(width: 4),
                      ],
                      Expanded(
                        child: Text(
                          item.titulo,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(item.resumo),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () => _abrirDetalhes(item),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
