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
  late final JogoRapidoController _controller;

  @override
  void dispose() {
    _controller.onClose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = Get.find<JogoRapidoController>();
    super.initState();
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
            animation: _controller.listenable,
            builder: (context, child) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: LinearProgressIndicator(
                          minHeight: 8,
                          value: _controller.progressoContador,
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
                        child: TextoEstilizado.h3(_controller.pontuacao),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
<<<<<<< Updated upstream
                      TextoEstilizado.h3(
                        controller.palavraJogada?.palavra ?? "",
=======
                      TextoEstilizado.h2(
                        _controller.palavraJogada?.palavra ?? "",
>>>>>>> Stashed changes
                      ),
                      const SizedBox(),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24.0),
                    child: Center(
                      child: BarraTentivas(
                        totalTentativas: 3,
                        tentativasRestantes: _controller.tentativas,
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
                            sinonimo: _controller.sinonimos[index],
                            selecionarResposta: () {
                              _controller.validarPalavraSelecionada(
                                _controller.sinonimos[index],
                              );
                            },
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        itemCount: _controller.sinonimos.length,
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
