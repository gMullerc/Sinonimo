import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/di/jogo_rapido_module.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/page/jogo_rapido.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/controller/selecao_dificuldade_controller.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/page/components/card_selecao_dificuldade.dart';
import 'package:sinonimo/theme/app_color.dart';

class SelecaoDificuldadePage extends StatefulWidget {
  const SelecaoDificuldadePage({super.key});

  @override
  State<SelecaoDificuldadePage> createState() => _SelecaoDificuldadePageState();
}

class _SelecaoDificuldadePageState extends State<SelecaoDificuldadePage> {
  late final SelecaoDificuldadeController _controller;

  @override
  void dispose() {
    _controller.onClose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = Get.find<SelecaoDificuldadeController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextoEstilizado.h1("Dificuldade"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            CardSelecaoDificuldade(
                              navegacao: () => Get.to(
                                () => const JogoRapido(),
                                binding: JogoRapidoModule(
                                  dificuldade: DificuldadeEnum.facil,
                                ),
                              ),
                              titulo: " Fácil",
                              descricao:
                                  "Tempo longo para responder, ganha mais tempo a cada acerto.",
                              melhorPontuacao:
                                  _controller.buscarPontuacaoPorDificuldade(
                                DificuldadeEnum.facil,
                              ),
                            ),
                            CardSelecaoDificuldade(
                              navegacao: () => Get.to(
                                () => const JogoRapido(),
                                binding: JogoRapidoModule(
                                  dificuldade: DificuldadeEnum.medio,
                                ),
                              ),
                              titulo: "Médio",
                              descricao:
                                  "Desafio equilibrado, tempo moderado para responder. Liberado com 1600 pontos no modo Fácil.",
                              melhorPontuacao:
                                  _controller.buscarPontuacaoPorDificuldade(
                                DificuldadeEnum.medio,
                              ),
                              faseDesbloqueada:
                                  _controller.validarDificuldadeLiberada(
                                DificuldadeEnum.medio,
                              ),
                            ),
                            CardSelecaoDificuldade(
                              navegacao: () => Get.to(
                                () => const JogoRapido(),
                                binding: JogoRapidoModule(
                                  dificuldade: DificuldadeEnum.dificil,
                                ),
                              ),
                              titulo: "Difícil",
                              descricao:
                                  "Teste sua agilidade! Tempo reduzido e sem margem para erros. Liberado com 2500 pontos no modo Médio.",
                              melhorPontuacao:
                                  _controller.buscarPontuacaoPorDificuldade(
                                DificuldadeEnum.dificil,
                              ),
                              faseDesbloqueada:
                                  _controller.validarDificuldadeLiberada(
                                DificuldadeEnum.dificil,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
