import 'dart:async';
import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/dialog_derrota.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/contador_usecase.dart';

typedef ValueNotifierListPalavras = ValueNotifier<List<PalavraPrincipalEntity>>;
typedef ValueNotifierListSinonimo = ValueNotifier<List<SinonimoEntity>>;
typedef ValueNotifierPalavra = ValueNotifier<PalavraPrincipalEntity?>;

class JogoRapidoController extends GetxController {
  late final ContadorUsecase _contadorUsecase;
  late final SinonimosRepository _sinonimosRepository;
  late final PresetsJogoRapido _presetsJogoRapido;

  JogoRapidoController({
    required SinonimosRepository sinonimosRepository,
    required PresetsJogoRapido presetsJogoRapido,
    required ContadorUsecase contadorUsecase,
  }) {
    _sinonimosRepository = sinonimosRepository;
    _presetsJogoRapido = presetsJogoRapido;
    _contadorUsecase = contadorUsecase;
  }

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

  PalavraPrincipalEntity? get palavraJogada => _palavraJogada.value;
  List<SinonimoEntity> get sinonimos => _sinonimos.value;
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

  void validarPalavraSelecionada(SinonimoEntity sinonimoSelecionado) {
    List<PalavraPrincipalEntity> palavras = _palavras.value;
    List<SinonimoEntity>? sinonimosPalavraSelecionada =
        palavraJogada?.sinonimos;

    SinonimoEntity? sinonimoFiltrado =
        sinonimosPalavraSelecionada?.firstWhereOrNull(
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
    Either<Failure, List<PalavraPrincipalEntity>> sinonimos =
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
    _contadorUsecase.setUltimaContagem = DateTime.now();
    _contadorUsecase.setTempoRestante = _presetsJogoRapido.tempoTotal * 1000;

    _contadorUsecase.setTimer = Timer.periodic(
      _contadorUsecase.intervalo,
      (timer) => _realizarContagemDoTempo(timer),
    );
  }

  _realizarContagemDoTempo(Timer timer) {
    final DateTime dateAtual = DateTime.now();

    final int tempoDecorridoEmMilisegundos =
        dateAtual.difference(_contadorUsecase.ultimaContagem!).inMilliseconds;

    _contadorUsecase.setUltimaContagem = dateAtual;

    _contadorUsecase.setTempoRestante =
        (_contadorUsecase.tempoRestante! - tempoDecorridoEmMilisegundos);
    if (_contadorUsecase.tempoRestante! <= 0) {
      _progressoContador.value = 0.0;
      timer.cancel();
      _mostrarDialogDerrota();
    } else {
      _progressoContador.value = _contadorUsecase.tempoRestante! /
          (_presetsJogoRapido.tempoTotal * 1000);
    }
  }

  void _adicionarTempoPorVelocidadeClicada() {
    if (_jogoIniciado) {
      _contadorUsecase.setTempoRestante = (_contadorUsecase.tempoRestante! +
              (_presetsJogoRapido.tempoPorAcerto * 1000))
          .clamp(0, _presetsJogoRapido.tempoTotal * 1000);
    }
  }

  void _resetarTimer() {
    if (_contadorUsecase.timer != null) {
      _contadorUsecase.timer?.cancel();
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

  Future<void> _sortearPalavraJogada() async {
    final random = Random();
    List<PalavraPrincipalEntity> palavras = _palavras.value;
    PalavraPrincipalEntity palavraJogada =
        palavras[random.nextInt(palavras.length)];
    Set<PalavraPrincipalEntity> palavrasIncorretas = {};

    while (palavrasIncorretas.length < 3) {
      int indexAleatorio = random.nextInt(palavras.length);

      PalavraPrincipalEntity palavraPrincipal = palavras[indexAleatorio];

      if (palavraJogada.id != palavraPrincipal.id) {
        palavrasIncorretas.add(palavras[random.nextInt(palavras.length)]);
      }
    }

    List<SinonimoEntity> sinonimos = [];

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

  void _mostrarDialogDerrota() {
    Get.dialog(DialogDerrota(
      fecharModal: () => {
        Get.back(),
        Get.back(),
      },
    ));
  }
}
