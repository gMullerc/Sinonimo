import 'package:flutter/material.dart';
import 'package:sinonimo/sinonimo/data/models/sinonimo_entity.dart';

class BotaoResposta extends StatelessWidget {
  final Sinonimo? sinonimo;
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
        ElevatedButton(
          onPressed: () => selecionarResposta(),
          child: Text(sinonimo?.nome ?? ""),
        ),
      ],
    );
  }
}
