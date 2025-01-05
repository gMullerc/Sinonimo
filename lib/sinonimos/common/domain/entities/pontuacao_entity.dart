import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/enum/modo_jogo_enum.dart';

class PontuacaoEntity {
  final double melhorPontuacao;
  final DificuldadeEnum dificuldade;
  final ModoJogoEnum modoJogo;

  PontuacaoEntity({
    required this.melhorPontuacao,
    required this.dificuldade,
    required this.modoJogo,
  });
}
