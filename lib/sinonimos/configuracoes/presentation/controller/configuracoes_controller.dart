import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:sinonimo/sinonimos/common/presentation/controller/audio_controller.dart';

class ConfiguracoesController extends GetxController {
  late final AudioController _audioController;

  ConfiguracoesController({
    required AudioController audioController,
  }) {
    _audioController = audioController;
  }

  @override
  void onInit() {
    _volumeMusica.value = _audioController.volumeMusica;
    _volumeEfeitos.value = _audioController.volumeEfeito;
    super.onInit();
  }

  final ValueNotifier<double> _volumeMusica = ValueNotifier(0.0);
  final ValueNotifier<double> _volumeEfeitos = ValueNotifier(0.0);

  Listenable get listenable {
    return Listenable.merge([
      _volumeMusica,
      _volumeEfeitos,
    ]);
  }

  double get volumeMusica => _volumeMusica.value;
  double get volumeEfeito => _volumeEfeitos.value;

  void alterarVolumeMusicaFundo(double volume) {
    _volumeMusica.value = volume;
    _audioController.alterarVolumeMusicaFundo(volume);
  }

  void alterarVolumeEfeitos(double volume) {
    _volumeEfeitos.value = volume;
    _audioController.alterarVolumeEfeitos(volume);
  }
}
