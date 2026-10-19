import 'package:flutter_test/flutter_test.dart';

import 'package:pdm_aula10_apis/models/noticia_model.dart';

void main() {
  test('NoticiaModel.fromJson mapeia os campos da API', () {
    final noticia = NoticiaModel.fromJson({
      'id': 1,
      'userId': 7,
      'title': 'Título',
      'body': 'Resumo',
    });

    expect(noticia.id, 1);
    expect(noticia.autorId, 7);
    expect(noticia.titulo, 'Título');
    expect(noticia.resumo, 'Resumo');
  });

  test('NoticiaModel.fromJson usa fallback para campos ausentes', () {
    final noticia = NoticiaModel.fromJson({});

    expect(noticia.id, 0);
    expect(noticia.autorId, 0);
    expect(noticia.titulo, '');
    expect(noticia.resumo, '');
  });
}
