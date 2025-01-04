import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';

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
      _sinonimosRepository.salvarSinonimosLocalmente();
    }
  }
}
