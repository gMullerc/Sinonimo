import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/pontuacao_repository.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/common/data/services/pontuacao_local_service.dart';
import 'package:sinonimo/sinonimos/common/data/services/sinonimo_local_service.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/presets_jogo_rapido.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/contador_usecase.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/escolha_usecase.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/usecases/pontuacao_usecase.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/controller/jogo_rapido_controller.dart';

class JogoRapidoModule extends Bindings {
  late DificuldadeEnum _dificuldade;
  JogoRapidoModule({required DificuldadeEnum dificuldade}) {
    _dificuldade = dificuldade;
  }

  @override
  void dependencies() {
    PresetsJogoRapido presetsJogoRapido = PresetsJogoRapido.fromDificuldade(
      _dificuldade,
    );

    Get.lazyPut<SinonimosLocalService>(() => SinonimosLocalServiceImpl());

    Get.lazyPut<SinonimosRepository>(
      () => SinonimosRepositoryImpl(
        sinonimosLocalDao: Get.find(),
      ),
    );

    Get.lazyPut<PontuacaoLocalService>(() => PontuacaoLocalServiceImpl());

    Get.lazyPut<PontuacaoRepository>(
      () => PontuacaoRepositoryImpl(pontuacaoLocalService: Get.find()),
    );

    Get.lazyPut<PontuacaoUsecase>(
      () => PontuacaoUsecaseImpl(pontuacaoRepository: Get.find()),
    );

    Get.lazyPut<ContadorUsecase>(
      () => ContadorUsecaseImpl(presetsJogoRapido: presetsJogoRapido),
    );

    Get.lazyPut<EscolhaUsecase>(
      () => EscolhaUsecaseImpl(
        presetsJogoRapido: presetsJogoRapido,
        audioController: Get.find(),
      ),
    );

    Get.lazyPut<JogoRapidoController>(
      () => JogoRapidoController(
        escolhaUsecase: Get.find(),
        contadorUsecase: Get.find(),
        sinonimosRepository: Get.find(),
        pontuacaoUsecase: Get.find(),
        presetsJogoRapido: presetsJogoRapido,
        dificuldade: _dificuldade,
      ),
    );
  }
}
