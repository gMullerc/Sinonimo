import 'package:flutter/material.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/jogo_rapido/domain/entities/informacao_final.dart';
import 'package:sinonimo/theme/app_color.dart';

class DialogDerrota extends StatelessWidget {
  final Function acaoFecharModal;
  final InformacaoFinal informacaoFinal;

  const DialogDerrota({
    super.key,
    required this.acaoFecharModal,
    required this.informacaoFinal,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backGroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  TextoEstilizado.h2(informacaoFinal.mensagem),
                  TextoEstilizado.h3(
                    "Pontuação final: ${informacaoFinal.pontuacao}",
                  ),
                  ElevatedButton(
                    onPressed: () => acaoFecharModal(),
                    child: const Text('Voltar para o menu'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
