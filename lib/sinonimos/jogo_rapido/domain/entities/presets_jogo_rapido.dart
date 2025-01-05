import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';

class PresetsJogoRapido {
  late final int _tempoTotal;
  late final double _pontuacaoPorAcerto;
  late final double _pontuacaoPorErro;
  late final int _tempoPorAcerto;
  late final int _tempoEmSegundoMaximoParaBonus;

  int get tempoTotal => _tempoTotal;
  int get tempoEmSegundoMaximoParaBonus => _tempoEmSegundoMaximoParaBonus;
  double get pontuacaoPorAcerto => _pontuacaoPorAcerto;
  double get pontuacaoPerdidaPorErro => _pontuacaoPorErro;
  int get tempoPorAcerto => _tempoPorAcerto;

  PresetsJogoRapido({
    double pontuacaoPorAcerto = 200.0,
    double pontuacaoPorErro = 150.0,
    int tempoTotal = 60,
    int tempoPorAcerto = 20,
    int tempoEmSegundoMaximoParaBonus = 12,
  }) {
    _tempoTotal = tempoTotal;
    _pontuacaoPorAcerto = pontuacaoPorAcerto;
    _pontuacaoPorErro = pontuacaoPorErro;
    _tempoPorAcerto = tempoPorAcerto;
    _tempoEmSegundoMaximoParaBonus = tempoEmSegundoMaximoParaBonus;
  }

  factory PresetsJogoRapido.fromDificuldade(DificuldadeEnum dificuldade) {
    switch (dificuldade) {
      case DificuldadeEnum.facil:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 200.0,
          pontuacaoPorErro: 70.0,
          tempoTotal: 90,
          tempoPorAcerto: 20,
          tempoEmSegundoMaximoParaBonus: 18,
        );
      case DificuldadeEnum.medio:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 250.0,
          pontuacaoPorErro: 70.0,
          tempoTotal: 20,
          tempoPorAcerto: 12,
          tempoEmSegundoMaximoParaBonus: 14,
        );
      case DificuldadeEnum.dificil:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 320.0,
          pontuacaoPorErro: 100.0,
          tempoTotal: 12,
          tempoPorAcerto: 07,
          tempoEmSegundoMaximoParaBonus: 10,
        );
    }
  }
}
