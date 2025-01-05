import 'dart:async';

import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';

abstract class ContadorUsecase {
  final Duration _intervalo = const Duration(milliseconds: 16);
  late Timer? _timer;
  late DateTime? _ultimaContagem;
  late int _tempoRestante;
  bool _jogoIniciado = false;

  Duration get intervalo => _intervalo;
  Timer? get timer => _timer;
  DateTime? get ultimaContagem => _ultimaContagem;
  int? get tempoRestante => _tempoRestante;
  bool get jogoIniciado => _jogoIniciado;

  set setTimer(Timer timer) => _timer = timer;
  set setJogoIniciado(bool jogoIniciado) => _jogoIniciado = jogoIniciado;
  set setUltimaContagem(DateTime ultimaContagem) =>
      _ultimaContagem = ultimaContagem;
  set setTempoRestante(int tempoRestante) => _tempoRestante = tempoRestante;

  void iniciarContador({
    required Function(double novoProgresso) alterarProgresso,
    required Function dialogDerrota,
  });

  void resetarTimer({
    required Function(double novoProgresso) alterarProgresso,
  });

  void adicionarTempoPorVelocidadeClicada();
}

class ContadorUsecaseImpl extends ContadorUsecase {
  late final PresetsJogoRapido _presetsJogoRapido;

  ContadorUsecaseImpl({
    required PresetsJogoRapido presetsJogoRapido,
  }) {
    _presetsJogoRapido = presetsJogoRapido;
  }
  @override
  void iniciarContador({
    required Function(double novoProgresso) alterarProgresso,
    required Function dialogDerrota,
  }) {
    setUltimaContagem = DateTime.now();
    setTempoRestante = _presetsJogoRapido.tempoTotal * 1000;

    setTimer = Timer.periodic(
      intervalo,
      (timer) => _realizarContagemDoTempo(
        timer,
        alterarProgresso: alterarProgresso,
        dialogDerrota: dialogDerrota,
      ),
    );
  }

  @override
  void resetarTimer({
    required Function(double novoProgresso) alterarProgresso,
  }) {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _jogoIniciado = false;
    _tempoRestante = 0;
    alterarProgresso(1.0);
  }

  void _realizarContagemDoTempo(
    Timer timer, {
    required Function(double novoProgresso) alterarProgresso,
    required Function dialogDerrota,
  }) {
    final DateTime dateAtual = DateTime.now();

    final int tempoDecorridoEmMilisegundos =
        dateAtual.difference(ultimaContagem!).inMilliseconds;

    setUltimaContagem = dateAtual;

    setTempoRestante = (tempoRestante! - tempoDecorridoEmMilisegundos);
    if (tempoRestante! <= 0) {
      alterarProgresso(0.0);
      timer.cancel();
      dialogDerrota();
    } else {
      alterarProgresso(tempoRestante! / (_presetsJogoRapido.tempoTotal * 1000));
    }
  }

  @override
  void adicionarTempoPorVelocidadeClicada() {
    if (jogoIniciado) {
      setTempoRestante =
          (tempoRestante! + (_presetsJogoRapido.tempoPorAcerto * 1000))
              .clamp(0, _presetsJogoRapido.tempoTotal * 1000);
    }
  }
}
