import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/barra_tentiva.dart';
import 'package:sinonimo/sinonimos/common/components/botao_escolha.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/controller/jogo_rapido_controller.dart';
import 'package:sinonimo/theme/app_color.dart';

class JogoRapido extends StatefulWidget {
  const JogoRapido({super.key});

  @override
  State<JogoRapido> createState() => _JogoRapidoState();
}

class _JogoRapidoState extends State<JogoRapido> {
  final controller = Get.find<JogoRapidoController>();

  @override
  void dispose() {
    controller.onClose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.backGroundGradient,
            backgroundBlendMode: BlendMode.multiply,
          ),
          child: AnimatedBuilder(
            animation: controller.listenable,
            builder: (context, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: controller.progressoContador,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        child: TextoEstilizado.h3(controller.pontuacao),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextoEstilizado.h2(
                        controller.palavraJogada?.palavra ?? "",
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: BarraTentivas(
                        totalTentativas: 3,
                        tentativasRestantes: controller.tentativas,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Center(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                          child: BotaoResposta(
                            sinonimo: controller.sinonimos[index],
                            selecionarResposta: () {
                              controller.validarPalavraSelecionada(
                                controller.sinonimos[index],
                              );
                            },
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        itemCount: controller.sinonimos.length,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
