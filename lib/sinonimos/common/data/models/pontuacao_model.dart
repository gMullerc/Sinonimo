import 'dart:convert';

import 'package:sinonimo/sinonimos/common/domain/entities/pontuacao_entity.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/enum/modo_jogo_enum.dart';

class PontuacaoModel extends PontuacaoEntity {
  PontuacaoModel({
    required super.melhorPontuacao,
    required String dificuldade,
    required String modoJogo,
  }) : super(
          modoJogo: ModoJogoEnum.fromString(modoJogo),
          dificuldade: DificuldadeEnum.fromString(dificuldade),
        );

  factory PontuacaoModel.fromMap(Map<String, dynamic> map) {
    return PontuacaoModel(
      melhorPontuacao: map['melhorPontuacao'] ?? "",
      dificuldade: map['dificuldade'] ?? "",
      modoJogo: map['modoJogo'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'melhorPontuacao': melhorPontuacao,
      'dificuldade': dificuldade.name,
      'modoJogo': modoJogo.name,
    };
  }

  String toJson() => json.encode(toMap());

  factory PontuacaoModel.fromEntity(PontuacaoEntity entity) {
    return PontuacaoModel(
      melhorPontuacao: entity.melhorPontuacao,
      dificuldade: entity.dificuldade.name,
      modoJogo: entity.modoJogo.name,
    );
  }
}
