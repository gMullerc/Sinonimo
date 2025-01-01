import 'dart:convert';

import 'package:sinonimo/sinonimos/common/data/models/sinonimo_model.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/palavra_principal_entity.dart';

class PalavraPrincipalModel extends PalavraPrincipalEntity {
  @override
  final String palavra;
  @override
  final String id;
  @override
  final List<SinonimoModel> sinonimos;

  PalavraPrincipalModel({
    required this.palavra,
    required this.id,
    required this.sinonimos,
  }) : super(palavra: palavra, id: id, sinonimos: sinonimos);

  factory PalavraPrincipalModel.fromMap(Map<String, dynamic> map) {
    return PalavraPrincipalModel(
      palavra: map['palavra'] ?? "",
      id: map['id'] ?? "",
      sinonimos: (map['sinonimos'] as List)
          .map((e) => SinonimoModel.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }
  factory PalavraPrincipalModel.fromEntity(PalavraPrincipalEntity entity) {
    return PalavraPrincipalModel(
      palavra: entity.palavra,
      id: entity.id,
      sinonimos: entity.sinonimos
          .map((sinonimo) => SinonimoModel.fromEntity(sinonimo))
          .toList(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'palavra': palavra,
      'id': id,
      'sinonimos': sinonimos.map((e) => e.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());
}
