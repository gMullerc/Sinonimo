import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/data/services/sinonimo_local_service.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/contador_usecase.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/controller/jogo_rapido_controller.dart';

class JogoRapidoModule extends Bindings {
  late DificuldadeEnum _dificuldade;
  JogoRapidoModule({required DificuldadeEnum dificuldade}) {
    _dificuldade = dificuldade;
  }

  @override
  void dependencies() {
    Get.lazyPut<SinonimosLocalService>(() => SinonimosLocalServiceImpl());
    Get.lazyPut<SinonimosRepository>(
      () => SinonimosRepositoryImpl(
        sinonimosLocalDao: Get.find(),
      ),
    );
    Get.lazyPut<ContadorUsecase>(
      () => ContadorUsecaseImpl(
        presetsJogoRapido: PresetsJogoRapido.fromDificuldade(_dificuldade),
      ),
    );
    Get.lazyPut<JogoRapidoController>(
      () => JogoRapidoController(
        contadorUsecase: Get.find(),
        sinonimosRepository: Get.find(),
        presetsJogoRapido: PresetsJogoRapido.fromDificuldade(_dificuldade),
      ),
    );
  }
}
