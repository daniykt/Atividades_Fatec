import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/noticia_model.dart';

// Sem try/catch: a exceção propaga e o FutureBuilder trata via snapshot.hasError
class NoticiaService {
  static const String _endpoint = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<NoticiaModel>> buscarNoticias() async {
    final response = await http.get(Uri.parse(_endpoint));

    if (response.statusCode == 200) {
      final List<dynamic> dados = jsonDecode(response.body);
      return dados.map((json) => NoticiaModel.fromJson(json)).toList();
    }
    throw Exception('Erro ao carregar notícias');
  }

  Future<List<Map<String, dynamic>>> buscarComentarios(int postId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$postId/comments'),
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    }
    throw Exception('Erro ao carregar comentários');
  }
}
