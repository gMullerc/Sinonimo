import 'package:flutter/material.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/theme/app_color.dart';

class CardSelecaoDificuldade extends StatelessWidget {
  final String titulo;
  final String descricao;
  final double? melhorPontuacao;
  final bool faseDesbloqueada;
  final Function navegacao;

  const CardSelecaoDificuldade({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.navegacao,
    this.faseDesbloqueada = true,
    this.melhorPontuacao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: faseDesbloqueada ? () => navegacao() : () {},
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.9,
        child: Card(
          surfaceTintColor: Colors.transparent,
          color: AppColors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: AppColors.primary, width: 4),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18.0,
              vertical: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextoEstilizado.h4(titulo),
                      Visibility(
                        visible: !faseDesbloqueada,
                        child: Image.asset(
                          "assets/uil_padlock.png",
                          fit: BoxFit.cover,
                          height: 18,
                          width: 18,
                          cacheHeight: 18,
                          cacheWidth: 18,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: TextoEstilizado.body(descricao),
                ),
                Visibility(
                  visible: melhorPontuacao != null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        TextoEstilizado.body("Melhor pontuação: "),
                        TextoEstilizado.body(
                          "$melhorPontuacao",
                          cor: AppColors.secondary,
                        ),
                      ],
                    ),
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
