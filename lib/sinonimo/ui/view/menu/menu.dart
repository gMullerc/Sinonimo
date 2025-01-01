import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/enums/dificuldade.dart';
import 'package:sinonimo/sinonimo/ui/binding/jogo_rapido/jogo_rapido_binding.dart';
import 'package:sinonimo/sinonimo/ui/view/jogo_rapido/jogo_rapido.dart';
import 'package:sinonimo/sinonimo/ui/view/menu/components/card_selecao_modo.dart';
import 'package:sinonimo/sinonimo/ui/view_model/menu/menu_view_model.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MenuViewModel>();
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
                        JogoRapidoBinding(dificuldade: DificuldadeEnum.dificil),
                  ),
                  titulo: "Jogo rápido",
                  descricao:
                      "Selecione a dificuldade e marque sua melhor pontuação",
                ),
                CardSelecaoModo(
                  navegacao: () => Get.to(
                    () => const JogoRapido(),
                    binding:
                        JogoRapidoBinding(dificuldade: DificuldadeEnum.facil),
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
