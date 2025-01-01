import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/di/jogo_rapido_module.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/presentation/page/jogo_rapido.dart';
import 'package:sinonimo/sinonimos/menu/presentation/components/card_selecao_modo.dart';
import 'package:sinonimo/sinonimos/menu/presentation/controllers/menu_controller.dart';

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
                tileMode: TileMode.repeated),
            color: Colors.blue,
            backgroundBlendMode: BlendMode.multiply,
          ),
          child: Center(
            child: Column(
              children: [
                const Text(
                  "Sinônimos",
                  style: TextStyle(color: Colors.white, fontSize: 34),
                ),
                CardSelecaoModo(
                  navegacao: () => Get.to(
                    () => const JogoRapido(),
                    binding:
                        JogoRapidoModule(dificuldade: DificuldadeEnum.dificil),
                  ),
                  titulo: "Jogo rápido",
                  descricao:
                      "Selecione a dificuldade e marque sua melhor pontuação",
                ),
                CardSelecaoModo(
                  navegacao: () => Get.to(
                    () => const JogoRapido(),
                    binding:
                        JogoRapidoModule(dificuldade: DificuldadeEnum.facil),
                  ),
                  titulo: "Como jogar?",
                  descricao:
                      "Selecione a dificuldade e marque sua melhor pontuação",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
