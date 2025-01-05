import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';

class PresetsJogoRapido {
  late final int _tempoTotal;
  late final double _pontuacaoGanhaPorAcerto;
  late final double _pontuacaoPerdidaPorErro;
  late final int _tempoPorAcerto;
  late final int _tempoEmSegundoMaximoParaBonus;

  int get tempoTotal => _tempoTotal;
  int get tempoEmSegundoMaximoParaBonus => _tempoEmSegundoMaximoParaBonus;
  double get pontuacaoPorAcerto => _pontuacaoGanhaPorAcerto;
  double get pontuacaoPerdidaPorErro => _pontuacaoPerdidaPorErro;
  int get tempoPorAcerto => _tempoPorAcerto;

  PresetsJogoRapido({
    double pontuacaoGanhaPorAcerto = 200.0,
    double pontuacaoPerdidaPorErro = -120.0,
    int tempoTotal = 60,
    int tempoPorAcerto = 20,
    int tempoEmSegundoMaximoParaBonus = 10,
  }) {
    _tempoTotal = tempoTotal;
    _pontuacaoGanhaPorAcerto = pontuacaoGanhaPorAcerto;
    _tempoPorAcerto = tempoPorAcerto;
    _tempoEmSegundoMaximoParaBonus = tempoEmSegundoMaximoParaBonus;
    _pontuacaoPerdidaPorErro = pontuacaoPerdidaPorErro;
  }

  factory PresetsJogoRapido.fromDificuldade(DificuldadeEnum dificuldade) {
    switch (dificuldade) {
      case DificuldadeEnum.facil:
        return PresetsJogoRapido(
          pontuacaoGanhaPorAcerto: 100.0,
          tempoTotal: 50,
          tempoPorAcerto: 20,
          tempoEmSegundoMaximoParaBonus: 18,
          pontuacaoPerdidaPorErro: -82,
        );
      case DificuldadeEnum.medio:
        return PresetsJogoRapido(
          pontuacaoGanhaPorAcerto: 200.0,
          tempoTotal: 20,
          tempoPorAcerto: 12,
          tempoEmSegundoMaximoParaBonus: 12,
          pontuacaoPerdidaPorErro: -120,
        );
      case DificuldadeEnum.dificil:
        return PresetsJogoRapido(
          pontuacaoGanhaPorAcerto: 225.0,
          tempoTotal: 12,
          tempoPorAcerto: 07,
          tempoEmSegundoMaximoParaBonus: 06,
          pontuacaoPerdidaPorErro: -175,
        );
    }
  }
}
