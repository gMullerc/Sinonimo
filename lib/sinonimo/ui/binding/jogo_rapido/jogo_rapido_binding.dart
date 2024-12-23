import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/data/dao/sinonimos_local_dao.dart';
import 'package:sinonimo/sinonimo/data/repositories/sinonimos_repository.dart';
import 'package:sinonimo/sinonimo/data/services/firebase_service.dart';
import 'package:sinonimo/sinonimo/ui/view_model/jogo_rapido/jogo_rapido_view_model.dart';

class JogoRapidoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FirebaseService>(() => FirebaseServiceImpl());
    Get.lazyPut<SinonimosLocalDao>(() => SinonimosLocalDaoImpl());
    Get.lazyPut<SinonimosRepository>(
      () => SinonimosRepositoryImpl(
          sinonimosFirebaseService: Get.find(), sinonimosLocalDao: Get.find()),
    );
    Get.lazyPut<JogoRapidoViewModel>(
      () => JogoRapidoViewModel(
        sinonimosRepository: Get.find(),
      ),
    );
  }
}
