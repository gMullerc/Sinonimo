import 'package:flutter/material.dart';
import 'package:sinonimo/theme/app_color.dart';

class BarraTentivas extends StatefulWidget {
  final int tentativasRestantes;
  final int totalTentativas;

  const BarraTentivas({
    super.key,
    required this.tentativasRestantes,
    required this.totalTentativas,
  });

  @override
  State<BarraTentivas> createState() => _BarraTentivasState();
}

class _BarraTentivasState extends State<BarraTentivas> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FractionallySizedBox(
            widthFactor: 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(3, (index) {
                return Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    height: 3,
                    color: index < widget.tentativasRestantes
                        ? AppColors.primary
                        : AppColors.secondary,
                  ),
                );
              }),
            ),
          ),
          // Outros widgets, se necessário
        ],
      ),
    );
  }
}
