import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:just_audio/just_audio.dart';

class AudioController extends GetxController {
  final AudioPlayer _playerSonsAcao = AudioPlayer();
  final AudioPlayer _playerMusicaFundo = AudioPlayer();

  late final String _musicaDeFundo;
  late final String _somAcerto;
  late final String _somErro;

  @override
  void onInit() async {
    super.onInit();
    _musicaDeFundo = 'assets/musica_de_fundo.mp3';
    _somAcerto = 'assets/som_acerto.mp3';
    _somErro = 'assets/som_erro.mp3';
  }

  @override
  void onClose() {
    super.onClose();
    _playerMusicaFundo.dispose();
    _playerSonsAcao.dispose();
  }

  double get volumeMusica => _playerMusicaFundo.volume;
  double get volumeEfeito => _playerSonsAcao.volume;

  Future<void> playMusicaFundo() async {
    await _playerMusicaFundo.setAsset(_musicaDeFundo);
    _playerMusicaFundo.setLoopMode(LoopMode.one);
    _playerMusicaFundo.play();
  }

  Future<void> playSomAcerto() async {
    await _playerSonsAcao.setAsset(_somAcerto);
    _playerSonsAcao.play();
  }

  Future<void> playSomErro() async {
    await _playerSonsAcao.setAsset(_somErro);
    _playerSonsAcao.play();
  }

  Future<void> pararMusicaFundo() async {
    await _playerMusicaFundo.pause();
  }

  Future<void> retomarMusicaFundo() async {
    await _playerMusicaFundo.play();
  }

  Future<void> alterarVolumeMusicaFundo(double volume) async {
    await _playerMusicaFundo.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> alterarVolumeEfeitos(double volume) async {
    await _playerSonsAcao.setVolume(volume.clamp(0.0, 1.0));
  }
}
