import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/data/failure/failure.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimo/data/repositories/sinonimos_repository.dart';

class MenuViewModel extends GetxController {
  late final SinonimosRepository _sinonimosRepository;

  MenuViewModel({required SinonimosRepository sinonimosRepository}) {
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
      Either<GenericFailure, List<PalavraPrincipal>> sinonimos =
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
