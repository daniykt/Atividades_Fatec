import 'package:flutter/material.dart';

import '../models/noticia_model.dart';
import '../services/noticia_service.dart';

class DetalheNoticiaScreen extends StatefulWidget {
  final NoticiaModel noticia;
  final bool favoritadoInicial;

  const DetalheNoticiaScreen({
    super.key,
    required this.noticia,
    this.favoritadoInicial = false,
  });

  @override
  State<DetalheNoticiaScreen> createState() => _DetalheNoticiaScreenState();
}

class _DetalheNoticiaScreenState extends State<DetalheNoticiaScreen> {
  final NoticiaService _service = NoticiaService();
  late Future<List<Map<String, dynamic>>> _futureComentarios;
  late bool _favoritado;

  @override
  void initState() {
    super.initState();
    _favoritado = widget.favoritadoInicial;
    _futureComentarios = _service.buscarComentarios(widget.noticia.id);
  }

  @override
  Widget build(BuildContext context) {
    final noticia = widget.noticia;
    final textTheme = Theme.of(context).textTheme;

    // Intercepta o "voltar" (AppBar ou gesto do sistema) para devolver
    // ao feed se a notícia está favoritada
    return PopScope<bool>(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.pop(context, _favoritado);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes da Notícia'),
          actions: [
            IconButton(
              icon: Icon(
                _favoritado ? Icons.favorite : Icons.favorite_border,
                color: _favoritado ? Colors.red : null,
              ),
              tooltip: _favoritado ? 'Remover dos favoritos' : 'Favoritar',
              onPressed: () => setState(() => _favoritado = !_favoritado),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: 'noticia-${noticia.id}',
                child: Image.network(
                  noticia.urlImagem,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 180,
                    color: Colors.grey.shade300,
                    child: const Icon(
                      Icons.image,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.person, size: 16),
                      label: Text(noticia.autor),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      noticia.titulo,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 24),
                    Text(
                      noticia.conteudoCompleto,
                      style: textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Text('Comentários', style: textTheme.titleLarge),
                    const SizedBox(height: 8),
                    _buildComentarios(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildComentarios() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _futureComentarios,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        }

        final comentarios = snapshot.data ?? [];
        if (comentarios.isEmpty) {
          return const Text('Nenhum comentário.');
        }

        // Column em vez de ListView: a rolagem já é feita pelo SingleChildScrollView
        return Column(
          children: comentarios.map((comment) {
            final String email = comment['email'] ?? '';
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 4),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(email.isNotEmpty ? email[0].toUpperCase() : '?'),
                ),
                title: Text(comment['name'] ?? ''),
                subtitle: Text(comment['body'] ?? ''),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
