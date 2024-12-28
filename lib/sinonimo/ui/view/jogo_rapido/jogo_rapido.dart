import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/ui/view/jogo_rapido/components/botao_resposta.dart';
import 'package:sinonimo/sinonimo/ui/view_model/jogo_rapido/jogo_rapido_view_model.dart';
import 'package:sinonimo/theme/app_color.dart';

class JogoRapido extends StatefulWidget {
  const JogoRapido({super.key});

  @override
  State<JogoRapido> createState() => _JogoRapidoState();
}

class _JogoRapidoState extends State<JogoRapido> {
  final controller = Get.find<JogoRapidoViewModel>();

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
            image: DecorationImage(
              image: AssetImage("assets/fundo.png"),
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 60, 60, 60),
                Color.fromARGB(255, 23, 23, 23),
              ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated,
            ),
            color: Colors.blue,
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
                      Column(
                        children: [
                          Text(
                            controller.tentativas,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            controller.pontuacao,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 24,
                            ),
                          ),
                          Text(
                            controller.palavraJogada?.palavra ?? "",
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
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
