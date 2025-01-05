import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sinonimo/sinonimos/common/data/repositories/sinonimo_repository.dart';
import 'package:sinonimo/sinonimos/common/presentation/controller/audio_controller.dart';

class MenuPageController extends GetxController {
  late final SinonimosRepository _sinonimosRepository;
  late final AudioController _audioController;

  final ValueNotifier<String> _version = ValueNotifier("");

  String get version => "v${_version.value}";

  MenuPageController({
    required SinonimosRepository sinonimosRepository,
    required AudioController audioController,
  }) {
    _sinonimosRepository = sinonimosRepository;
    _audioController = audioController;
  }

  Listenable get listenable {
    return Listenable.merge([
      _version,
    ]);
  }

  @override
  void onInit() async {
    super.onInit();

    await _audioController.playMusicaFundo();
    await obterVersaoApp();
    verificarExistenciaDosDados();
  }

  Future<void> obterVersaoApp() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    _version.value = packageInfo.version;
  }

  Future<void> verificarExistenciaDosDados() async {
    bool existeDadosLocais =
        await _sinonimosRepository.verificarExistenciaDosDados();

    if (!existeDadosLocais) {
      _sinonimosRepository.salvarSinonimosLocalmente();
    }
  }
}
