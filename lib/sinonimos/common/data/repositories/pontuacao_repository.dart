import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimos/common/data/models/pontuacao_model.dart';
import 'package:sinonimo/sinonimos/common/data/services/pontuacao_local_service.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/pontuacao_entity.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/enum/modo_jogo_enum.dart';
import 'package:sinonimo/sinonimos/common/failures/excpetions.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';

abstract class PontuacaoRepository {
  Future<void> salvarNovaMelhorPontuacao(PontuacaoEntity pontuacao);
  Future<Either<Failure, List<PontuacaoEntity>>> buscarMelhoresPontuacoes();
  Future<Either<Failure, PontuacaoEntity>>
      buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  );
}

class PontuacaoRepositoryImpl extends PontuacaoRepository {
  late final PontuacaoLocalService _pontuacaoLocalService;
  PontuacaoRepositoryImpl({
    required PontuacaoLocalService pontuacaoLocalService,
  }) {
    _pontuacaoLocalService = pontuacaoLocalService;
  }

  @override
  Future<Either<Failure, PontuacaoEntity>>
      buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  ) async {
    try {
      Map<String, dynamic> pontuacao = await _pontuacaoLocalService
          .buscarMelhorPontuacoesByDificuldadeAndModo(dificuldade, modoJogo);

      PontuacaoModel pontuacaoModel = PontuacaoModel.fromMap(pontuacao);

      return Right(pontuacaoModel);
    } on NotFoundException catch (e) {
      return Left(GenericFailure(e.mensagem));
    } on Exception catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PontuacaoEntity>>>
      buscarMelhoresPontuacoes() async {
    try {
      List<Map<String, dynamic>> pontuacao =
          await _pontuacaoLocalService.buscarMelhoresPontuacoes();

      List<PontuacaoModel> pontuacaoModel =
          pontuacao.map((e) => PontuacaoModel.fromMap(e)).toList();

      return Right(pontuacaoModel);
    } on NotFoundException catch (e) {
      return Left(GenericFailure(e.mensagem));
    } on Exception catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> salvarNovaMelhorPontuacao(
    PontuacaoEntity pontuacao,
  ) async {
    try {
      PontuacaoModel pontuacaoModel = PontuacaoModel.fromEntity(pontuacao);

      await _pontuacaoLocalService.salvarNovaMelhorPontuacao(
        pontuacaoModel.toMap(),
      );

      return const Right(null);
    } on Exception catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }
}
