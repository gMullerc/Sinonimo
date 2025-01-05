import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:sinonimo/extensions/string_extensions.dart';
import 'package:sinonimo/sinonimos/common/data/models/palavra_principal_model.dart';
import 'package:sinonimo/sinonimos/common/data/services/sinonimo_local_service.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';
import 'package:uuid/uuid.dart';

abstract class SinonimosRepository {
  Future<Either<GenericFailure, void>> salvarSinonimosLocalmente();
  Future<Either<GenericFailure, List<PalavraPrincipalEntity>>>
      buscarSinonimosLocais();
  Future<bool> verificarExistenciaDosDados();
}

class SinonimosRepositoryImpl extends SinonimosRepository {
  late final SinonimosLocalService _sinonimosLocalDao;

  SinonimosRepositoryImpl({
    required SinonimosLocalService sinonimosLocalDao,
  }) {
    _sinonimosLocalDao = sinonimosLocalDao;
  }

  @override
  Future<Either<GenericFailure, void>> salvarSinonimosLocalmente() async {
    try {
      String jsonString = await rootBundle.loadString('assets/dados.json');
      List<dynamic> data = jsonDecode(jsonString);

      List<PalavraPrincipalEntity> palavrasRecuperadas = [];

      for (var item in data) {
        String palavra = item['palavra'];

        List<String> sinonimosRaw = item['sinonimos'].split(',');

        PalavraPrincipalEntity palavraPrincipalEntity = PalavraPrincipalEntity(
          palavra: palavra.capitalize(),
          id: const Uuid().v4(),
          sinonimos: sinonimosRaw
              .map((e) =>
                  SinonimoEntity(nome: e.capitalize(), id: const Uuid().v4()))
              .toList(),
        );

        palavrasRecuperadas.add(palavraPrincipalEntity);
      }

      await _sinonimosLocalDao.insertSinonimos(palavrasRecuperadas
          .map((e) => PalavraPrincipalModel.fromEntity(e))
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
