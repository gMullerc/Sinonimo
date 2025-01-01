import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';

class PresetsJogoRapido {
  late final int _tempoTotal;
  late final double _pontuacaoPorAcerto;
  late final int _tempoPorAcerto;

  int get tempoTotal => _tempoTotal;
  double get pontuacaoPorAcerto => _pontuacaoPorAcerto;
  int get tempoPorAcerto => _tempoPorAcerto;

  PresetsJogoRapido({
    double pontuacaoPorAcerto = 200.0,
    int tempoTotal = 60,
    int tempoPorAcerto = 20,
  }) {
    _tempoTotal = tempoTotal;
    _pontuacaoPorAcerto = pontuacaoPorAcerto;
    _tempoPorAcerto = tempoPorAcerto;
  }

  factory PresetsJogoRapido.fromDificuldade(DificuldadeEnum dificuldade) {
    switch (dificuldade) {
      case DificuldadeEnum.facil:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 100.0,
          tempoTotal: 90,
          tempoPorAcerto: 20,
        );
      case DificuldadeEnum.medio:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 200.0,
          tempoTotal: 20,
          tempoPorAcerto: 12,
        );
      case DificuldadeEnum.dificil:
        return PresetsJogoRapido(
          pontuacaoPorAcerto: 225.0,
          tempoTotal: 12,
          tempoPorAcerto: 07,
        );
      default:
        throw Exception('Dificuldade não reconhecida');
    }
  }
}
