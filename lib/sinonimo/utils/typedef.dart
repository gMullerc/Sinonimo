import 'package:dartz/dartz.dart';
import 'package:sinonimo/sinonimo/data/failure/failure.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';

typedef EitherFailureListListDynamic
    = Future<Either<Failure, List<List<dynamic>>>>;

typedef FutureListMapStringDynamic = Future<List<Map<String, dynamic>>>;

typedef FutureEitherListPalavraPrincipal
    = Future<Either<GenericFailure, List<PalavraPrincipal>>>;

typedef FutureBool = Future<bool>;

typedef FutureEitherVoid = Future<Either<Failure, void>>;
typedef FutureVoid = Future<void>;
