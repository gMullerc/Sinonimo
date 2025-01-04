import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/di/jogo_rapido_module.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/page/jogo_rapido.dart';
import 'package:sinonimo/sinonimos/menu/presentation/components/card_selecao_modo.dart';
import 'package:sinonimo/sinonimos/menu/presentation/controllers/menu_controller.dart';
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
        child: Container(
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
                  flex: 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextoEstilizado.h1("Sinônimos"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      CardSelecaoMenu(
                        navegacao: () => Get.to(
                          () => const JogoRapido(),
                          binding: JogoRapidoModule(
                              dificuldade: DificuldadeEnum.dificil),
                        ),
                        titulo: "Jogo rápido",
                      ),
                      CardSelecaoMenu(
                        navegacao: () => Get.to(
                          () => const TutorialPage(),
                        ),
                        titulo: "Como jogar",
                      )
                    ],
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
                const Expanded(
                  child: Text("v.0.0.1"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
