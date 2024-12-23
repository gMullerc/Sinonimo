import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimo/data/dao/sinonimos_local_dao.dart';
import 'package:sinonimo/sinonimo/data/failure/failure.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimo/data/models/sinonimo_entity.dart';
import 'package:sinonimo/sinonimo/data/services/firebase_service.dart';
import 'package:sinonimo/sinonimo/utils/typedef.dart';

abstract class SinonimosRepository {
  FutureEitherListPalavraPrincipal getSinonimos();
  FutureEitherVoid salvarSinonimosLocalmente(List<PalavraPrincipal> palavras);
  FutureEitherListPalavraPrincipal buscarSinonimosLocais();
  FutureBool verificarExistenciaDosDados();
}

class SinonimosRepositoryImpl extends SinonimosRepository {
  late final FirebaseService _sinonimosFirebaseService;
  late final SinonimosLocalDao _sinonimosLocalDao;

  SinonimosRepositoryImpl({
    required FirebaseService sinonimosFirebaseService,
    required SinonimosLocalDao sinonimosLocalDao,
  }) {
    _sinonimosFirebaseService = sinonimosFirebaseService;
    _sinonimosLocalDao = sinonimosLocalDao;
  }

  @override
  FutureEitherListPalavraPrincipal getSinonimos() async {
    try {
      List<Map<String, dynamic>> sinonimosMap =
          await _sinonimosFirebaseService.getSinonimos();

      List<PalavraPrincipal> palavrasPrincipais = [];

      for (var sinonimo in sinonimosMap) {
        String nomePalavraPrincipal = sinonimo["nome"];

        String id = sinonimo["id"];
        List<dynamic> sinonimos = sinonimo["sinonimos"];

        PalavraPrincipal palavraPrincipal = PalavraPrincipal(
          id: id,
          palavra: nomePalavraPrincipal,
          sinonimos: sinonimos
              .map((e) => Sinonimo(
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
  FutureEitherVoid salvarSinonimosLocalmente(
    List<PalavraPrincipal> palavras,
  ) async {
    try {
      await _sinonimosLocalDao.insertSinonimos(palavras);

      return const Right(null);
    } catch (e) {
      return Left(GenericFailure(e.toString()));
    }
  }

  @override
  FutureEitherListPalavraPrincipal buscarSinonimosLocais() async {
    try {
      List<Map<String, dynamic>> sinonimosMap =
          await _sinonimosLocalDao.getSinonimos();

      for (var teste in sinonimosMap) {
        var teste2 = teste['value'];
        print(teste2);
      }
      List<PalavraPrincipal> palavrasPrincipais = sinonimosMap
          .map((sinonimo) => PalavraPrincipal.fromMap(sinonimo))
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
  FutureBool verificarExistenciaDosDados() async {
    try {
      return _sinonimosLocalDao.verificarExistenciaDosDados();
    } catch (e) {
      return false;
    }
  }
}
