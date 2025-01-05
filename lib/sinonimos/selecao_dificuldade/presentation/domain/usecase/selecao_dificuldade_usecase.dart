import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/pontuacao_repository.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/pontuacao_entity.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';

abstract class SelecaoDificuldadeUsecase {
  Future<Either<Failure, List<PontuacaoEntity>>> buscarMelhoresPontuacoes();
}

class SelecaoDificuldadeUsecaseImpl extends SelecaoDificuldadeUsecase {
  late final PontuacaoRepository _pontuacaoRepository;

  SelecaoDificuldadeUsecaseImpl({
    required PontuacaoRepository pontuacaoRepository,
  }) {
    _pontuacaoRepository = pontuacaoRepository;
  }

  @override
  Future<Either<Failure, List<PontuacaoEntity>>> buscarMelhoresPontuacoes() {
    return _pontuacaoRepository.buscarMelhoresPontuacoes();
  }
}
