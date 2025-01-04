import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/data/services/sinonimo_local_service.dart';
import 'package:sinonimo/sinonimos/menu/presentation/controllers/menu_controller.dart';

class MenuModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SinonimosLocalService>(() => SinonimosLocalServiceImpl());
    Get.lazyPut<SinonimosRepository>(
      () => SinonimosRepositoryImpl(sinonimosLocalDao: Get.find()),
    );
    Get.lazyPut<MenuPageController>(() => MenuPageController(
          sinonimosRepository: Get.find(),
        ));
  }
}
