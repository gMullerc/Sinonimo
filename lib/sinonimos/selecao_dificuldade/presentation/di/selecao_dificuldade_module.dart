import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/controller/selecao_dificuldade_controller.dart';

class SelecaoDificuldadeModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelecaoDificuldadeController>(
      () => SelecaoDificuldadeController(),
    );
  }
}
