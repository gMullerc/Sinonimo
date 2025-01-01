import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimos/common/failures/failure.dart';

class MenuPageController extends GetxController {
  late final SinonimosRepository _sinonimosRepository;

  MenuPageController({required SinonimosRepository sinonimosRepository}) {
    _sinonimosRepository = sinonimosRepository;
  }

  @override
  void onInit() {
    super.onInit();
    verificarExistenciaDosDados();
  }

  Future<void> verificarExistenciaDosDados() async {
    bool existeDadosLocais =
        await _sinonimosRepository.verificarExistenciaDosDados();

    if (!existeDadosLocais) {
      Either<GenericFailure, List<PalavraPrincipalEntity>> sinonimos =
          await _sinonimosRepository.getSinonimos();
      sinonimos.fold(
        (left) => Get.snackbar(
          "Ocorreu um erro ao buscar os dados",
          left.mensagemErro,
        ),
        (right) {
          _sinonimosRepository.salvarSinonimosLocalmente(right);
        },
      );
    }
  }
}
