import 'package:flutter/material.dart';
import 'package:sinonimo/extensions/string_extensions.dart';
import 'package:sinonimo/sinonimos/common/components/texto_estilizado.dart';
import 'package:sinonimo/sinonimos/common/domain/entities/sinonimo_entity.dart';

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
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            onPressed: () => selecionarResposta(),
            child: TextoEstilizado.h3(
              sinonimo?.nome.capitalize() ?? "",
            ),
          ),
        ),
      ],
    );
  }
}
