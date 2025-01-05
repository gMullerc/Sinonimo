import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/pontuacao_repository.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/pontuacao_entity.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/enum/modo_jogo_enum.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';

abstract class PontuacaoUsecase {
  Future<void> salvarNovaMelhorPontuacao(PontuacaoEntity pontuacao);
  Future<Either<Failure, PontuacaoEntity>>
      buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  );
}

class PontuacaoUsecaseImpl extends PontuacaoUsecase {
  late final PontuacaoRepository _pontuacaoRepository;

  PontuacaoUsecaseImpl({required PontuacaoRepository pontuacaoRepository}) {
    _pontuacaoRepository = pontuacaoRepository;
  }

  @override
  Future<Either<Failure, PontuacaoEntity>>
      buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  ) {
    return _pontuacaoRepository.buscarMelhorPontuacoesByDificuldadeAndModo(
      dificuldade,
      modoJogo,
    );
  }

  @override
  Future<void> salvarNovaMelhorPontuacao(PontuacaoEntity pontuacao) async {
    await _pontuacaoRepository.salvarNovaMelhorPontuacao(pontuacao);
  }
}
