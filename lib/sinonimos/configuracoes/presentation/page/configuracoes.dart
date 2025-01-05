import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/configuracoes/presentation/controller/configuracoes_controller.dart';
import 'package:sinonimo/theme/app_color.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late final ConfiguracoesController _controller;
  @override
  void initState() {
    _controller = Get.find<ConfiguracoesController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _controller.listenable,
            builder: (context, _) {
              return Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: AppColors.backGroundGradient,
                  backgroundBlendMode: BlendMode.multiply,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextoEstilizado.h2("Configurações"),
                      ],
                    ),
                    Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 32),
                      surfaceTintColor: Colors.transparent,
                      color: AppColors.black,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: AppColors.primary, width: 1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextoEstilizado.h3("Controle de áudio"),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextoEstilizado.h4("Música"),
                                Expanded(
                                  child: Slider(
                                    value: _controller.volumeMusica,
                                    min: 0.0,
                                    max: 1.0,
                                    thumbColor: AppColors.primary,
                                    activeColor: AppColors.primary,
                                    inactiveColor: AppColors.white,
                                    onChanged: (value) => _controller
                                        .alterarVolumeMusicaFundo(value),
                                    label:
                                        "${(_controller.volumeMusica * 100).toInt()}%",
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextoEstilizado.h4("Efeitos"),
                                Expanded(
                                  child: Slider(
                                    value: _controller.volumeEfeito,
                                    min: 0.0,
                                    max: 1.0,
                                    onChanged: (value) {
                                      _controller.alterarVolumeEfeitos(value);
                                    },
                                    thumbColor: AppColors.primary,
                                    activeColor: AppColors.primary,
                                    inactiveColor: AppColors.white,
                                    label:
                                        "${(_controller.volumeEfeito * 100).toInt()}%",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
