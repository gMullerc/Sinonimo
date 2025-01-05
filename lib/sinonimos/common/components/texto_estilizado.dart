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
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displayLarge!.copyWith(
            fontSize: 42,
            fontWeight: fontWeight,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.h2(
    String texto, {
    Color cor = AppColors.onPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displayLarge!.copyWith(
            fontSize: 24,
            fontWeight: fontWeight,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.h3(
    String texto, {
    Color cor = AppColors.onPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displayMedium!.copyWith(
            fontSize: 18,
            fontWeight: fontWeight,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.h4(
    String texto, {
    Color cor = AppColors.onPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().displaySmall!.copyWith(
            fontSize: 14,
            fontWeight: fontWeight,
            color: cor,
          ),
    );
  }

  factory TextoEstilizado.body(
    String texto, {
    Color cor = AppColors.onPrimary,
    FontWeight fontWeight = FontWeight.w600,
  }) {
    return TextoEstilizado._(
      texto,
      GoogleFonts.playpenSansTextTheme().bodyLarge!.copyWith(
            fontSize: 12,
            fontWeight: fontWeight,
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
