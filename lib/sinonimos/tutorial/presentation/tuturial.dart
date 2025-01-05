import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/theme/app_color.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
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
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextoEstilizado.h2("Como Jogar"),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextoEstilizado.h4(
                        """Neste jogo, você verá uma palavra na tela e o objetivo é acertar o sinônimo dela. Fique atento! Você tem um tempo limitado e um número de tentativas.
                  
A cada resposta correta, o tempo e a pontuação aumentam de acordo com a rapidez com que você acerta. Mas cuidado! Se errar, você perderá pontos. O jogo acaba quando o tempo se esgota ou quando você excede o limite de tentativas.
                  
Prepare-se, pense rápido e desafie sua mente!"""),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
