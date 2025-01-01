import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinonimo/sinonimos/common/data/models/palavra_principal_model.dart';

abstract class SinonimosLocalService {
  Future<void> insertSinonimos(List<PalavraPrincipalModel> palavras);
  Future<List<Map<String, dynamic>>> getSinonimos();
  Future<bool> verificarExistenciaDosDados();
}

class SinonimosLocalServiceImpl extends SinonimosLocalService {
  final String _sinonimosKey = "sinonimos_key_";

  @override
  Future<void> insertSinonimos(List<PalavraPrincipalModel> palavras) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    for (var palavra in palavras) {
      prefs.setString("$_sinonimosKey${palavra.id}", palavra.toJson());
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSinonimos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var keys = prefs.getKeys().where((key) => key.contains(_sinonimosKey));

    List<Map<String, dynamic>> sinonimos = [];
    for (var key in keys) {
      final String? jsonString = prefs.getString(key);
      if (jsonString != null) {
        sinonimos.add({
          'key': key,
          'value': jsonString,
        });
      }
    }

    return sinonimos
        .map((e) => jsonDecode(e['value']) as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<bool> verificarExistenciaDosDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs
        .getKeys()
        .where((key) => key.contains(_sinonimosKey))
        .isNotEmpty;
  }
}
