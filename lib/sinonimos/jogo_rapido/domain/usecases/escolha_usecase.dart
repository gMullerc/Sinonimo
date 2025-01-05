import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';

abstract class EscolhaUsecase {
  late DateTime? _ultimaResposta;

  DateTime? get ultimaResposta => _ultimaResposta;
  set setUltimaResposta(DateTime ultimaResposta) {
    _ultimaResposta = ultimaResposta;
  }

  void acaoPalavraCorretaSelecionada({
    required Function(double value) alterarPontuacao,
    required Function adicionarTempoPorVelocidadeClicada,
  });

  void acaoPalavraIncorretaSelecionada({
    required Function(double value) atualizarPontuacao,
    required Function atualizarTentativas,
  });

  void resetarPartidaRapida();
}

class EscolhaUsecaseImpl extends EscolhaUsecase {
  late final PresetsJogoRapido _presetsJogoRapido;

  EscolhaUsecaseImpl({required PresetsJogoRapido presetsJogoRapido}) {
    _presetsJogoRapido = presetsJogoRapido;
  }

  @override
  void acaoPalavraCorretaSelecionada({
    required Function(double value) alterarPontuacao,
    required Function adicionarTempoPorVelocidadeClicada,
  }) {
    double pontuacaoPadrao = _presetsJogoRapido.pontuacaoPorAcerto;

    final int tempoEmSegundoMaximoParaBonus =
        _presetsJogoRapido.tempoEmSegundoMaximoParaBonus;

    bool isInicialized = false;

    try {
      var value = _ultimaResposta;
      isInicialized = true;
    } catch (e) {
      isInicialized = false;
    }

    if (isInicialized && _ultimaResposta != null) {
      DateTime tempoAtual = DateTime.now();

      int diferencaDesdeUltimaResposta =
          tempoAtual.difference(_ultimaResposta!).inSeconds;

      if (diferencaDesdeUltimaResposta <= tempoEmSegundoMaximoParaBonus) {
        pontuacaoPadrao *=
            (tempoEmSegundoMaximoParaBonus - diferencaDesdeUltimaResposta) / 10;
      }

      _ultimaResposta = tempoAtual;
    } else {
      _ultimaResposta = DateTime.now();
    }

    alterarPontuacao(pontuacaoPadrao);
    adicionarTempoPorVelocidadeClicada();
  }

  @override
  void acaoPalavraIncorretaSelecionada({
    required Function(double value) atualizarPontuacao,
    required Function atualizarTentativas,
  }) {
    atualizarPontuacao(_presetsJogoRapido.pontuacaoPerdidaPorErro);
    atualizarTentativas();
  }

  @override
  void resetarPartidaRapida() {
    _ultimaResposta = null;
  }
}
