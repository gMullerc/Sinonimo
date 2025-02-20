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
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/informacao_final.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/contador_usecase.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/escolha_usecase.dart';

typedef ValueNotifierListPalavras = ValueNotifier<List<PalavraPrincipalEntity>>;
typedef ValueNotifierListSinonimo = ValueNotifier<List<SinonimoEntity>>;
typedef ValueNotifierPalavra = ValueNotifier<PalavraPrincipalEntity?>;

class JogoRapidoController extends GetxController {
  late final ContadorUsecase _contadorUsecase;

  late final EscolhaUsecase _escolhaUsecase;
  late final SinonimosRepository _sinonimosRepository;
  late final PresetsJogoRapido _presetsJogoRapido;

  JogoRapidoController({
    required SinonimosRepository sinonimosRepository,
    required PresetsJogoRapido presetsJogoRapido,
    required ContadorUsecase contadorUsecase,
    required EscolhaUsecase escolhaUsecase,
  }) {
    _sinonimosRepository = sinonimosRepository;
    _presetsJogoRapido = presetsJogoRapido;
    _contadorUsecase = contadorUsecase;
    _escolhaUsecase = escolhaUsecase;
  }

  int tempoAdicionalPorAcerto = 0;
  bool _partidaEncerrada = false;

  ValueNotifier<String?> error = ValueNotifier(null);

  final ValueNotifier<double> _progressoContador = ValueNotifier(1.0);
  final ValueNotifier<double> _pontuacao = ValueNotifier(0.0);
  final ValueNotifier<int> _tentativas = ValueNotifier(3);
  final ValueNotifierListPalavras _palavrasIncorretas = ValueNotifier([]);
  final ValueNotifierListPalavras _palavras = ValueNotifier([]);
  final ValueNotifierPalavra _palavraJogada = ValueNotifier(null);
  final ValueNotifierListSinonimo _sinonimos = ValueNotifier([]);

  PalavraPrincipalEntity? get palavraJogada => _palavraJogada.value;
  List<SinonimoEntity> get sinonimos => _sinonimos.value;
  String get pontuacao => _pontuacao.value.toString();
  int get tentativas => _tentativas.value;
  double get progressoContador => _progressoContador.value;

  void setProgressoContador(double novoProgresso) {
    if (novoProgresso != 0) {
      _progressoContador.value = novoProgresso;
      return;
    }
    _progressoContador.value = 0.0;
  }

  void setPontuacao(double novaPontuacao) {
    if (novaPontuacao != 0.0) {
      _pontuacao.value += novaPontuacao;
      return;
    }
    _pontuacao.value = 0.0;
  }

  void setTentativas(int novaTentativa) {
    if (novaTentativa != 0) {
      _tentativas.value += novaTentativa;
      return;
    }
    _tentativas.value = 0;
  }

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
  void onInit() async {
    super.onInit();
    _getSinonimos();
  }

  @override
  void onClose() {
    _contadorUsecase.resetarTimer(alterarProgresso: setProgressoContador);
    _escolhaUsecase.resetarPartidaRapida();
    _resetarPartidaRapida();
    super.onClose();
  }

  Future<void> _resetarPartidaRapida() async {
    _partidaEncerrada = false;
    _pontuacao.value = 0;
    _tentativas.value = 3;
  }

  void validarPalavraSelecionada(SinonimoEntity sinonimoSelecionado) async {
    List<PalavraPrincipalEntity> palavras = _palavras.value;
    List<SinonimoEntity>? sinonimosPalavraSelecionada =
        palavraJogada?.sinonimos;

    SinonimoEntity? sinonimoFiltrado =
        sinonimosPalavraSelecionada?.firstWhereOrNull(
      (sinonimo) => sinonimo.id == sinonimoSelecionado.id,
    );

    if (sinonimoFiltrado != null) {
      _escolhaUsecase.acaoPalavraCorretaSelecionada(
        alterarPontuacao: setPontuacao,
        adicionarTempoPorVelocidadeClicada:
            _contadorUsecase.adicionarTempoPorVelocidadeClicada,
      );
    } else {
      _escolhaUsecase.acaoPalavraIncorretaSelecionada(
        atualizarPontuacao: _atualizarPontuacao,
        atualizarTentativas: _atualizarTentativas,
      );
    }

    _resetarSinonimos();

    palavras.removeWhere((palavra) => palavra.id == palavraJogada?.id);
    await _sortearPalavraJogada(palavras: _palavras.value);

    if (!_contadorUsecase.jogoIniciado && !_partidaEncerrada) {
      _contadorUsecase.setJogoIniciado = true;
      _contadorUsecase.iniciarContador(
        dialogDerrota: () => _mostrarDialogDerrota("Tempo esgotado!"),
        alterarProgresso: setProgressoContador,
      );
    }
  }

  Future<void> _getSinonimos() async {
    Either<Failure, List<PalavraPrincipalEntity>> sinonimos =
        await _sinonimosRepository.buscarSinonimosLocais();

    sinonimos.fold(
      (left) => error.value = left.mensagemErro,
      (right) async {
        _palavras.value = right;
        await _sortearPalavraJogada(palavras: right);
      },
    );
  }

  void _atualizarPontuacao(double pontuacao) {
    setPontuacao((_pontuacao.value - pontuacao) > 0 && _pontuacao.value != 0.0
        ? pontuacao
        : 0.0);
  }

  void _atualizarTentativas() {
    if ((_tentativas.value - 1) > 0) {
      setTentativas(-1);
    } else {
      _finalizarPartidaPorTentativas();
    }
  }

  void _finalizarPartidaPorTentativas() {
    setTentativas(0);
    _partidaEncerrada = true;
    _contadorUsecase.resetarTimer(
      alterarProgresso: setProgressoContador,
    );
    _mostrarDialogDerrota("Tentativas esgotadas");
  }

  void _resetarSinonimos() {
    _sinonimos.value.clear();
  }

  Future<void> _sortearPalavraJogada({
    required List<PalavraPrincipalEntity> palavras,
  }) async {
    final random = Random();
    if (palavras.isNotEmpty) {
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
  }

  void _mostrarDialogDerrota(String mensagemDerrota) {
    Get.dialog(
      DialogDerrota(
        informacaoFinal: InformacaoFinal(
          pontuacao: _pontuacao.value,
          tentativasRestantes: _tentativas.value,
          mensagem: mensagemDerrota,
        ),
        fecharModal: () => {
          Get.back(),
          Get.back(),
        },
      ),
    );
  }
}
