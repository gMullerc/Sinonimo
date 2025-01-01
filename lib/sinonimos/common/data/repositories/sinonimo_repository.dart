import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimos/common/data/models/palavra_principal_model.dart';
import 'package:sinonimo/sinonimos/common/data/services/firebase_service.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/data/services/sinonimo_local_service.dart';

abstract class SinonimosRepository {
  Future<Either<GenericFailure, List<PalavraPrincipalEntity>>> getSinonimos();
  Future<Either<GenericFailure, void>> salvarSinonimosLocalmente(
    List<PalavraPrincipalEntity> palavras,
  );
  Future<Either<GenericFailure, List<PalavraPrincipalEntity>>>
      buscarSinonimosLocais();
  Future<bool> verificarExistenciaDosDados();
}

class SinonimosRepositoryImpl extends SinonimosRepository {
  late final FirebaseService _sinonimosFirebaseService;
  late final SinonimosLocalService _sinonimosLocalDao;

  SinonimosRepositoryImpl({
    required FirebaseService sinonimosFirebaseService,
    required SinonimosLocalService sinonimosLocalDao,
  }) {
    _sinonimosFirebaseService = sinonimosFirebaseService;
    _sinonimosLocalDao = sinonimosLocalDao;
  }

  @override
  Future<Either<GenericFailure, List<PalavraPrincipalEntity>>>
      getSinonimos() async {
    try {
      List<Map<String, dynamic>> sinonimosMap =
          await _sinonimosFirebaseService.getSinonimos();

      List<PalavraPrincipalEntity> palavrasPrincipais = [];

      for (var sinonimo in sinonimosMap) {
        String nomePalavraPrincipal = sinonimo["nome"];

        String id = sinonimo["id"];
        List<dynamic> sinonimos = sinonimo["sinonimos"];

        PalavraPrincipalEntity palavraPrincipal = PalavraPrincipalEntity(
          id: id,
          palavra: nomePalavraPrincipal,
          sinonimos: sinonimos
              .map((e) => SinonimoEntity(
                    nome: e['nome'],
                    id: e['id'],
                  ))
              .toList(),
        );

        palavrasPrincipais.add(palavraPrincipal);
      }

      if (palavrasPrincipais.isNotEmpty) {
        return Right(palavrasPrincipais);
      }
      return Left(GenericFailure("Nenhum resultado encontrado"));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<GenericFailure, void>> salvarSinonimosLocalmente(
    List<PalavraPrincipalEntity> palavras,
  ) async {
    try {
      await _sinonimosLocalDao.insertSinonimos(palavras
          .map((palavra) => PalavraPrincipalModel.fromEntity(palavra))
          .toList());

      return const Right(null);
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<Either<GenericFailure, List<PalavraPrincipalEntity>>>
      buscarSinonimosLocais() async {
    try {
      List<Map<String, dynamic>> sinonimosMap =
          await _sinonimosLocalDao.getSinonimos();

      List<PalavraPrincipalEntity> palavrasPrincipais = sinonimosMap
          .map((sinonimo) => PalavraPrincipalModel.fromMap(sinonimo))
          .toList();

      if (palavrasPrincipais.isNotEmpty) {
        return Right(palavrasPrincipais);
      }
      return Left(GenericFailure("Nenhum resultado encontrado"));
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  Future<bool> verificarExistenciaDosDados() async {
    try {
      return _sinonimosLocalDao.verificarExistenciaDosDados();
    } catch (e) {
      return false;
    }
  }
}
