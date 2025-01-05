import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/pontuacao_repository.dart';
import 'package:sinonimo/sinonimos/common/data/services/pontuacao_local_service.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/controller/selecao_dificuldade_controller.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/domain/usecase/selecao_dificuldade_usecase.dart';

class SelecaoDificuldadeModule extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PontuacaoLocalService>(
      () => PontuacaoLocalServiceImpl(),
    );
    Get.lazyPut<PontuacaoRepository>(
      () => PontuacaoRepositoryImpl(pontuacaoLocalService: Get.find()),
    );
    Get.lazyPut<SelecaoDificuldadeUsecase>(
      () => SelecaoDificuldadeUsecaseImpl(pontuacaoRepository: Get.find()),
    );
    Get.lazyPut<SelecaoDificuldadeController>(
      () => SelecaoDificuldadeController(selecaoDificuldadeUsecase: Get.find()),
    );
  }
}
