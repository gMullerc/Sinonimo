import 'dart:convert';

import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';

class SinonimoModel extends SinonimoEntity {
  @override
  final String nome;
  @override
  final String id;

  SinonimoModel({
    required this.nome,
    required this.id,
  }) : super(nome: nome, id: id);

  factory SinonimoModel.fromMap(Map<String, dynamic> map) {
    return SinonimoModel(
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

  factory SinonimoModel.fromEntity(SinonimoEntity entity) {
    return SinonimoModel(
      nome: entity.nome,
      id: entity.id,
    );
  }
}
