import 'package:flutter/material.dart';
import 'package:sinonimo/extensions/string_extensions.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';
import 'package:sinonimo/theme/app_color.dart';

class BotaoResposta extends StatelessWidget {
  final SinonimoEntity? sinonimo;
  final Function selecionarResposta;

  const BotaoResposta({
    required this.sinonimo,
    required this.selecionarResposta,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: AppColors.secondary,
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 6,
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.pressed)) {
                    return AppColors.secondary;
                  }
                  return AppColors.primary;
                },
              ),
              shadowColor: WidgetStateProperty.resolveWith<Color>(
                (states) {
                  if (states.contains(WidgetState.pressed)) {
                    return const Color.fromARGB(255, 248, 252, 255);
                  }
                  return AppColors.secondary;
                },
              ),
            ),
            onPressed: () => selecionarResposta(),
            child: TextoEstilizado.h3(
              fontWeight: FontWeight.w500,
              sinonimo?.nome.capitalize() ?? "",
            ),
          ),
        ),
      ],
    );
  }
}
