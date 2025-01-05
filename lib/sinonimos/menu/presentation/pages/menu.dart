import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/configuracoes/presentation/di/configuracoes_module.dart';
import 'package:sinonimo/sinonimos/configuracoes/presentation/page/configuracoes.dart';
import 'package:sinonimo/sinonimos/menu/presentation/components/card_selecao_modo.dart';
import 'package:sinonimo/sinonimos/menu/presentation/controllers/menu_controller.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/di/selecao_dificuldade_module.dart';
import 'package:sinonimo/sinonimos/selecao_dificuldade/presentation/page/selecao_dificuldade.dart';
import 'package:sinonimo/sinonimos/tutorial/presentation/tuturial.dart';
import 'package:sinonimo/theme/app_color.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late final MenuPageController _controller;

  @override
  void initState() {
    _controller = Get.find<MenuPageController>();
    super.initState();
  }

  @override
  void dispose() {
    _controller.onClose();
    super.dispose();
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
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextoEstilizado.h1("Sinônimos"),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            CardSelecaoMenu(
                              navegacao: () => Get.to(
                                () => const SelecaoDificuldadePage(),
                                binding: SelecaoDificuldadeModule(),
                              ),
                              titulo: "Jogo rápido",
                            ),
                            CardSelecaoMenu(
                              navegacao: () =>
                                  Get.to(() => const TutorialPage()),
                              titulo: "Como jogar",
                            ),
                            CardSelecaoMenu(
                              navegacao: () => Get.to(
                                () => const ConfiguracoesPage(),
                                binding: ConfiguracoesModule(),
                              ),
                              titulo: "Configurações",
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Text(_controller.version),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
