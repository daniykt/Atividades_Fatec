class NoticiaModel {
  final int id;
  final String titulo;
  final String resumo;
  final String conteudoCompleto;
  final String autor;
  final String urlImagem;

  const NoticiaModel({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudoCompleto,
    required this.autor,
    required this.urlImagem,
  });

  factory NoticiaModel.fromJson(Map<String, dynamic> json) {
    final String corpo = json['body'] ?? '';

    return NoticiaModel(
      id: json['id'] ?? 0,
      titulo: json['title'] ?? 'Sem título',
      resumo: corpo.length > 40 ? '${corpo.substring(0, 40)}...' : corpo,
      conteudoCompleto: json['body'] ?? 'Sem conteúdo disponível.',
      autor: 'Autor ID ${json['userId']?.toString() ?? '1'}',
      // Lorem Picsum gera uma imagem determinística para cada seed
      urlImagem: 'https://picsum.photos/seed/${json['id']}/800/400',
    );
  }
}
