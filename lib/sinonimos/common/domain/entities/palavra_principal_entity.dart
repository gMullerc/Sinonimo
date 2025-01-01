import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';

class PalavraPrincipalEntity {
  final String palavra;
  final String id;
  final List<SinonimoEntity> sinonimos;

  PalavraPrincipalEntity({
    required this.palavra,
    required this.id,
    required this.sinonimos,
  });
}
