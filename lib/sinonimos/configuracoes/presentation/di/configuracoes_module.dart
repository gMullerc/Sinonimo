import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/configuracoes/presentation/controller/configuracoes_controller.dart';

class ConfiguracoesModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfiguracoesController>(
      () => ConfiguracoesController(
        audioController: Get.find(),
      ),
    );
  }
}
