import 'dart:async';

abstract class ContadorUsecase {
  final Duration _intervalo = const Duration(milliseconds: 16);
  late Timer? _timer;
  late DateTime? _ultimaContagem;
  late int _tempoRestante;

  Duration get intervalo => _intervalo;
  Timer? get timer => _timer;
  DateTime? get ultimaContagem => _ultimaContagem;
  int? get tempoRestante => _tempoRestante;

  set setTimer(Timer timer) => _timer = timer;
  set setUltimaContagem(DateTime ultimaContagem) =>
      _ultimaContagem = ultimaContagem;
  set setTempoRestante(int tempoRestante) => _tempoRestante = tempoRestante;
}

class ContadorUsecaseImpl extends ContadorUsecase {}
