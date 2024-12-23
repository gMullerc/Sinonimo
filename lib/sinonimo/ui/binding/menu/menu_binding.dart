import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/data/dao/sinonimos_local_dao.dart';
import 'package:sinonimo/sinonimo/data/repositories/sinonimos_repository.dart';
import 'package:sinonimo/sinonimo/data/services/firebase_service.dart';
import 'package:sinonimo/sinonimo/ui/view_model/menu/menu_view_model.dart';

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseServiceImpl());
    Get.lazyPut<SinonimosLocalDao>(() => SinonimosLocalDaoImpl());
    Get.lazyPut<SinonimosRepository>(
      () => SinonimosRepositoryImpl(
          sinonimosFirebaseService: Get.find(), sinonimosLocalDao: Get.find()),
    );
    Get.lazyPut<MenuViewModel>(
      () => MenuViewModel(
        sinonimosRepository: Get.find(),
      ),
    );
  }
}
