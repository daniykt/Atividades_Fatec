import 'package:flutter/material.dart';

import '../models/noticia_model.dart';

class DetalheNoticiaScreen extends StatelessWidget {
  final NoticiaModel noticia;

  const DetalheNoticiaScreen({super.key, required this.noticia});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da Notícia')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chip(
              avatar: const Icon(Icons.person),
              label: Text('Autor ID ${noticia.autorId}'),
            ),
            const SizedBox(height: 16),
            Text(
              noticia.titulo,
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(height: 32),
            Text(
              noticia.resumo,
              style: textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
