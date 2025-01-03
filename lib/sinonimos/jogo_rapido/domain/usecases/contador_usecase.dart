import 'dart:async';

import 'package:flutter/material.dart';
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
    required ValueNotifier<double> progressoContador,
    required Function dialogDerrota,
  });

  void resetarTimer({required ValueNotifier<double> progressoContador});
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
    required ValueNotifier<double> progressoContador,
    required Function dialogDerrota,
  }) {
    setUltimaContagem = DateTime.now();
    setTempoRestante = _presetsJogoRapido.tempoTotal * 1000;

    setTimer = Timer.periodic(
      intervalo,
      (timer) => _realizarContagemDoTempo(
        timer,
        progressoContador: progressoContador,
        dialogDerrota: dialogDerrota,
      ),
    );
  }

  @override
  void resetarTimer({required ValueNotifier<double> progressoContador}) {
    if (timer != null) {
      _timer?.cancel();
      _timer = null;
      _jogoIniciado = false;
      _tempoRestante = 0;
      progressoContador.value = 0.0;
    }
  }

  void _realizarContagemDoTempo(
    Timer timer, {
    required ValueNotifier<double> progressoContador,
    required Function dialogDerrota,
  }) {
    final DateTime dateAtual = DateTime.now();

    final int tempoDecorridoEmMilisegundos =
        dateAtual.difference(ultimaContagem!).inMilliseconds;

    setUltimaContagem = dateAtual;

    setTempoRestante = (tempoRestante! - tempoDecorridoEmMilisegundos);
    if (tempoRestante! <= 0) {
      progressoContador.value = 0.0;
      timer.cancel();
      dialogDerrota();
    } else {
      progressoContador.value =
          tempoRestante! / (_presetsJogoRapido.tempoTotal * 1000);
    }
  }
}
