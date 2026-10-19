import 'package:flutter_test/flutter_test.dart';

import 'package:pdm_aula11_master_detail/models/noticia_model.dart';

void main() {
  test(
    'NoticiaModel.fromJson mapeia os campos e corta o resumo em 40 chars',
    () {
      final body = 'a' * 50;
      final noticia = NoticiaModel.fromJson({
        'id': 3,
        'userId': 7,
        'title': 'Título',
        'body': body,
      });

      expect(noticia.id, 3);
      expect(noticia.titulo, 'Título');
      expect(noticia.resumo, '${'a' * 40}...');
      expect(noticia.conteudoCompleto, body);
      expect(noticia.autor, 'Autor ID 7');
      expect(noticia.urlImagem, 'https://picsum.photos/seed/3/800/400');
    },
  );

  test('NoticiaModel.fromJson usa fallback para campos ausentes', () {
    final noticia = NoticiaModel.fromJson({});

    expect(noticia.id, 0);
    expect(noticia.titulo, 'Sem título');
    expect(noticia.resumo, '');
    expect(noticia.conteudoCompleto, 'Sem conteúdo disponível.');
    expect(noticia.autor, 'Autor ID 1');
  });
}
