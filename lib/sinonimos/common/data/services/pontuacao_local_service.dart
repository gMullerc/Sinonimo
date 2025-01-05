import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinonimo/sinonimos/common/enum/dificuldade_enum.dart';
import 'package:sinonimo/sinonimos/common/enum/modo_jogo_enum.dart';
import 'package:sinonimo/sinonimos/common/failures/excpetions.dart';

abstract class PontuacaoLocalService {
  Future<void> salvarNovaMelhorPontuacao(Map<String, dynamic> mapPontuacao);
  Future<List<Map<String, dynamic>>> buscarMelhoresPontuacoes();
  Future<Map<String, dynamic>> buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  );
}

class PontuacaoLocalServiceImpl extends PontuacaoLocalService {
  final String _melhorPontuacaoKey = "melhor_pontuacao_key_";

  @override
  Future<Map<String, dynamic>> buscarMelhorPontuacoesByDificuldadeAndModo(
    DificuldadeEnum dificuldade,
    ModoJogoEnum modoJogo,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? key = prefs
        .getKeys()
        .where((key) =>
            key.contains("$_melhorPontuacaoKey${dificuldade}_$modoJogo"))
        .firstOrNull;

    String? json = prefs.getString(key ?? "");

    if (json != null) {
      return jsonDecode(json);
    }

    throw NotFoundException(mensagem: "Melhor pontuação não encontrada");
  }

  @override
  Future<List<Map<String, dynamic>>> buscarMelhoresPontuacoes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Set<String> keys = prefs.getKeys();

    List<Map<String, dynamic>> pontuacoes = [];

    for (var key in keys) {
      String? json = prefs.getString(key);

      if (json != null) {
        pontuacoes.add(jsonDecode(json));
      }
    }

    if (pontuacoes.isNotEmpty) {
      return pontuacoes;
    }

    throw NotFoundException(mensagem: "Melhores pontuações não encontradas");
  }

  @override
  Future<void> salvarNovaMelhorPontuacao(
    Map<String, dynamic> mapPontuacao,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString(
      "$_melhorPontuacaoKey$mapPontuacao['dificuldade']_$mapPontuacao['modoJogo']",
      jsonEncode(mapPontuacao),
    );
  }
}
