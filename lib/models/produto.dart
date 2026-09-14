/// Modelo de dados que representa um produto do catálogo.
///
/// Aplica os conceitos de Orientação a Objetos em Dart:
/// - Tipagem estrita mapeada a partir do JSON
/// - Imutabilidade (atributos `final`)
/// - Null safety com parâmetros nomeados obrigatórios (`required`)
/// - Regra de negócio encapsulada em getter
/// - Desserialização segura via `factory fromJson`
class Produto {
  final String nomeProduto;
  final String categoria;
  final double preco;
  final int quantidadeEstoque;
  final bool disponivel;
  final List<String> tags;

  const Produto({
    required this.nomeProduto,
    required this.categoria,
    required this.preco,
    required this.quantidadeEstoque,
    required this.disponivel,
    required this.tags,
  });

  /// Retorna `true` quando o estoque está abaixo de 5 unidades.
  bool get temEstoqueCritico => quantidadeEstoque < 5;

  /// Constrói um [Produto] a partir de um `Map` (JSON desserializado),
  /// realizando conversões seguras de tipos numéricos e da lista de tags.
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      nomeProduto: json['nome_produto'] as String,
      categoria: json['categoria'] as String,
      preco: (json['preco'] as num).toDouble(),
      quantidadeEstoque: (json['quantidade_estoque'] as num).toInt(),
      disponivel: json['disponivel'] as bool,
      tags: List<String>.from(json['tags'] as List),
    );
  }
}
