import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/data/failure/failure.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimo/data/models/sinonimo_entity.dart';
import 'package:sinonimo/sinonimo/data/repositories/sinonimos_repository.dart';
import 'package:sinonimo/sinonimo/utils/typedef.dart';

typedef ValueNotifierListPalavras = ValueNotifier<List<PalavraPrincipal>>;
typedef ValueNotifierListSinonimo = ValueNotifier<List<Sinonimo>>;
typedef ValueNotifierPalavra = ValueNotifier<PalavraPrincipal?>;

class JogoRapidoViewModel extends GetxController {
  late final SinonimosRepository _sinonimosRepository;

  JogoRapidoViewModel({required SinonimosRepository sinonimosRepository}) {
    _sinonimosRepository = sinonimosRepository;
  }

  ValueNotifier<String?> error = ValueNotifier(null);
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

  Listenable get listenable {
    return Listenable.merge([
      _palavrasIncorretas,
      _palavraJogada,
      _tentativas,
      _pontuacao,
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    _getSinonimos();
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

  void _acaoPalavraCorretaSelecionada() {
    _pontuacao.value += 300;
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
    _sinonimos.value.addAll(sinonimos);
  }
}
