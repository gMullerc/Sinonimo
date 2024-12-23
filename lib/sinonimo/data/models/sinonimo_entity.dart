import 'dart:convert';

class Sinonimo {
  final String nome;
  final String id;

  Sinonimo({
    required this.nome,
    required this.id,
  });

  factory Sinonimo.fromMap(Map<String, dynamic> map) {
    return Sinonimo(
      nome: map['nome'] ?? "",
      id: map['id'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());
}
