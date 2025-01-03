import 'package:flutter/material.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/theme/app_color.dart';

class CardSelecaoMenu extends StatelessWidget {
  final String titulo;
  final Function navegacao;

  const CardSelecaoMenu({
    super.key,
    required this.titulo,
    required this.navegacao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navegacao(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
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
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  TextoEstilizado.h3(titulo),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
