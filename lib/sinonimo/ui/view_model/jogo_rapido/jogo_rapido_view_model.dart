import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/data/failure/failure.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimo/data/models/sinonimo_entity.dart';
import 'package:sinonimo/sinonimo/data/repositories/sinonimos_repository.dart';
import 'package:sinonimo/sinonimo/ui/binding/jogo_rapido/jogo_rapido_binding.dart';
import 'package:sinonimo/sinonimo/utils/typedef.dart';

typedef ValueNotifierListPalavras = ValueNotifier<List<PalavraPrincipal>>;
typedef ValueNotifierListSinonimo = ValueNotifier<List<Sinonimo>>;
typedef ValueNotifierPalavra = ValueNotifier<PalavraPrincipal?>;

class JogoRapidoViewModel extends GetxController {
  late final SinonimosRepository _sinonimosRepository;

  late final PresetsJogoRapido _presetsJogoRapido;

  JogoRapidoViewModel({
    required SinonimosRepository sinonimosRepository,
    required PresetsJogoRapido presetsJogoRapido,
  }) {
    _sinonimosRepository = sinonimosRepository;
    _presetsJogoRapido = presetsJogoRapido;
  }

  final Duration _intervalo = const Duration(milliseconds: 16);
  late Timer? _timer;
  late DateTime? _ultimaContagem;
  late int tempoRestante;
  bool _jogoIniciado = false;

  int tempoAdicionalPorAcerto = 0;

  ValueNotifier<String?> error = ValueNotifier(null);

  final ValueNotifier<double> _progressoContador = ValueNotifier(1.0);
  final ValueNotifier<int> _pontuacao = ValueNotifier(0);
  final ValueNotifier<int> _tentativas = ValueNotifier(3);
  final ValueNotifierListPalavras _palavrasIncorretas = ValueNotifier([]);
  final ValueNotifierListPalavras _palavras = ValueNotifier([]);
  final ValueNotifierPalavra _palavraJogada = ValueNotifier(null);
  final ValueNotifierListSinonimo _sinonimos = ValueNotifier([]);

  PalavraPrincipal? get palavraJogada => _palavraJogada.value;
  List<Sinonimo> get sinonimos => _sinonimos.value;
  String get pontuacao => _pontuacao.value.toString();
  String get tentativas => _tentativas.value.toString();
  double get progressoContador => _progressoContador.value;

  Listenable get listenable {
    return Listenable.merge([
      _palavrasIncorretas,
      _palavraJogada,
      _tentativas,
      _pontuacao,
      _progressoContador
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    _getSinonimos();
  }

  @override
  void onClose() {
    _resetarTimer();
    super.onClose();
  }

  void validarPalavraSelecionada(Sinonimo sinonimoSelecionado) {
    List<PalavraPrincipal> palavras = _palavras.value;
    List<Sinonimo>? sinonimosPalavraSelecionada = palavraJogada?.sinonimos;

    Sinonimo? sinonimoFiltrado = sinonimosPalavraSelecionada?.firstWhereOrNull(
      (sinonimo) => sinonimo.id == sinonimoSelecionado.id,
    );

    if (sinonimoFiltrado != null) {
      _acaoPalavraCorretaSelecionada();
    } else {
      _acaoPalavraIncorretaSelecionada();
    }
    _resetarSinonimos();
    palavras.removeWhere((palavra) => palavra.id == palavraJogada?.id);
    _sortearPalavraJogada();

    if (!_jogoIniciado) {
      _jogoIniciado = true;
      _iniciarContador();
    }
  }

  Future<void> _getSinonimos() async {
    Either<Failure, List<PalavraPrincipal>> sinonimos =
        await _sinonimosRepository.buscarSinonimosLocais();

    sinonimos.fold(
      (left) => error.value = left.mensagemErro,
      (right) async {
        _palavras.value = right;
        await _sortearPalavraJogada();
      },
    );
  }

  void _iniciarContador() {
    _ultimaContagem = DateTime.now();
    tempoRestante = _presetsJogoRapido.tempoTotal * 1000;

    _timer = Timer.periodic(
      _intervalo,
      (timer) => _realizarContagemDoTempo(timer),
    );
  }

  _realizarContagemDoTempo(Timer timer) {
    final DateTime dateAtual = DateTime.now();

    final int tempoDecorridoEmMilisegundos =
        dateAtual.difference(_ultimaContagem!).inMilliseconds;

    _ultimaContagem = dateAtual;

    tempoRestante = (tempoRestante - tempoDecorridoEmMilisegundos);
    if (tempoRestante <= 0) {
      _progressoContador.value = 0.0;
      timer.cancel();
      Get.back();
    } else {
      _progressoContador.value =
          tempoRestante / (_presetsJogoRapido.tempoTotal * 1000);
    }
  }

  void _adicionarTempoPorVelocidadeClicada() {
    if (_jogoIniciado) {
      tempoRestante =
          (tempoRestante + (_presetsJogoRapido.tempoPorAcerto * 1000))
              .clamp(0, _presetsJogoRapido.tempoTotal * 1000);
    }
  }

  void _resetarTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _jogoIniciado = false;
      _progressoContador.value = 0.0;
    }
  }

  void _acaoPalavraCorretaSelecionada() {
    _pontuacao.value += 300;
    _adicionarTempoPorVelocidadeClicada();
  }

  void _acaoPalavraIncorretaSelecionada() {
    _pontuacao.value -= 300;
    _tentativas.value -= 1;
  }

  void _resetarSinonimos() {
    _sinonimos.value.clear();
  }

  FutureVoid _sortearPalavraJogada() async {
    final random = Random();
    List<PalavraPrincipal> palavras = _palavras.value;
    PalavraPrincipal palavraJogada = palavras[random.nextInt(palavras.length)];
    Set<PalavraPrincipal> palavrasIncorretas = {};

    while (palavrasIncorretas.length < 3) {
      int indexAleatorio = random.nextInt(palavras.length);

      PalavraPrincipal palavraPrincipal = palavras[indexAleatorio];

      if (palavraJogada.id != palavraPrincipal.id) {
        palavrasIncorretas.add(palavras[random.nextInt(palavras.length)]);
      }
    }

    List<Sinonimo> sinonimos = [];

    for (var palavra in palavrasIncorretas) {
      int indexSinonimoAleatorio = random.nextInt(palavra.sinonimos.length);

      sinonimos.add(palavra.sinonimos[indexSinonimoAleatorio]);
    }

    int indexSinonimoCorreto = random.nextInt(palavraJogada.sinonimos.length);

    sinonimos.add(palavraJogada.sinonimos[indexSinonimoCorreto]);

    _palavraJogada.value = palavraJogada;
    sinonimos.shuffle();
    _sinonimos.value.addAll(sinonimos);
  }
}
