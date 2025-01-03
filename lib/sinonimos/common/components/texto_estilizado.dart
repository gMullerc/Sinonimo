import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sinonimo/theme/app_color.dart';

class TextoEstilizado extends StatelessWidget {
  final String texto;
  final TextStyle estilo;

  const TextoEstilizado._(this.texto, this.estilo);

  factory TextoEstilizado.h1(
    String texto, {
    Color cor = AppColors.onPrimary,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displayLarge!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.h2(
    String texto, {
    Color cor = AppColors.onPrimary,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displayMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.h3(
    String texto, {
    Color cor = AppColors.onPrimary,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displaySmall!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.body(
    String texto, {
    Color cor = AppColors.onPrimary,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().bodyLarge!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: cor,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      texto,
      style: estilo,
    );
  }
}
