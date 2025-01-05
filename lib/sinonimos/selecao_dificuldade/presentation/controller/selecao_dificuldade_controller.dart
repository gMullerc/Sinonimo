import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/pontuacao_entity.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/domain/usecase/selecao_dificuldade_usecase.dart';

class SelecaoDificuldadeController extends GetxController {
  late final SelecaoDificuldadeUsecase _selecaoDificuldadeUsecase;
  SelecaoDificuldadeController({
    required SelecaoDificuldadeUsecase selecaoDificuldadeUsecase,
  }) {
    _selecaoDificuldadeUsecase = selecaoDificuldadeUsecase;
  }
  final ValueNotifier<List<PontuacaoEntity>> _pontuacoes = ValueNotifier([]);

  List<PontuacaoEntity> get pontuacoes => _pontuacoes.value;

  Listenable get listenable {
    return Listenable.merge([
      _pontuacoes,
    ]);
  }

  @override
  void onInit() {
    super.onInit();
    _buscarMelhoresPontuacoes();
  }

  void _buscarMelhoresPontuacoes() async {
    Either<Failure, List<PontuacaoEntity>> pontuacoes =
        await _selecaoDificuldadeUsecase.buscarMelhoresPontuacoes();

    pontuacoes.fold(
      (l) => null,
      (sucesso) => _pontuacoes.value = sucesso,
    );
  }

  double? buscarPontuacaoPorDificuldade(DificuldadeEnum dificuldade) {
    PontuacaoEntity? pontuacaoEntity = _pontuacoes.value.firstWhereOrNull(
      (pontuacao) => pontuacao.dificuldade == dificuldade,
    );

    if (pontuacaoEntity != null) {
      return pontuacaoEntity.melhorPontuacao;
    }
    return null;
  }

  bool validarDificuldadeLiberada(DificuldadeEnum dificuldade) {
    PontuacaoEntity? pontuacaoEntity = _pontuacoes.value.firstWhereOrNull(
      (pontuacao) => pontuacao.dificuldade == dificuldade.dificuldadeAnterior,
    );

    return pontuacaoEntity != null &&
        pontuacaoEntity.melhorPontuacao >= dificuldade.pontuacaoMinima;
  }
}
