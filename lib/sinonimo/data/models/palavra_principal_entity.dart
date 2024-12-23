import 'dart:convert';

import 'package:sinonimo/sinonimo/data/models/sinonimo_entity.dart';

class PalavraPrincipal {
  final String palavra;
  final String id;
  final List<Sinonimo> sinonimos;

  PalavraPrincipal({
    required this.palavra,
    required this.id,
    required this.sinonimos,
  });

  factory PalavraPrincipal.fromMap(Map<String, dynamic> map) {
    return PalavraPrincipal(
      palavra: map['palavra'] ?? "",
      id: map['id'] ?? "",
      sinonimos: (map['sinonimos'] as List)
          .map((e) => Sinonimo.fromMap(e as Map<String, dynamic>))
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
