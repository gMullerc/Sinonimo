import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimo/ui/view/jogo_rapido/components/botao_resposta.dart';
import 'package:sinonimo/sinonimo/ui/view_model/jogo_rapido/jogo_rapido_view_model.dart';

class JogoRapido extends StatefulWidget {
  const JogoRapido({super.key});

  @override
  State<JogoRapido> createState() => _JogoRapidoState();
}

class _JogoRapidoState extends State<JogoRapido> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<JogoRapidoViewModel>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: AnimatedBuilder(
            animation: controller.listenable,
            builder: (context, child) {
              return Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: 0.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.black),
                          backgroundColor: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(controller.tentativas),
                        ],
                      ),
                      Column(
                        children: [
                          Text(controller.pontuacao),
                          Text(controller.palavraJogada?.palavra ?? ""),
                        ],
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Center(
                    child: Container(
                      color: Colors.amber,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => BotaoResposta(
                              sinonimo: controller.sinonimos[index],
                              selecionarResposta: () {
                                controller.validarPalavraSelecionada(
                                  controller.sinonimos[index],
                                );
                              },
                            ),
                            itemCount: controller.sinonimos.length,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
