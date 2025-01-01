import 'package:flutter/material.dart';

class CardSelecaoModo extends StatelessWidget {
  final String titulo;
  final String descricao;
  final Function navegacao;

  const CardSelecaoModo({
    super.key,
    required this.titulo,
    required this.navegacao,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navegacao(),
      child: FractionallySizedBox(
        alignment: Alignment.center,
        widthFactor: 0.9,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text(descricao),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
