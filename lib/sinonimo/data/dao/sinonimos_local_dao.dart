import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sinonimo/sinonimo/data/models/palavra_principal_entity.dart';
import 'package:sinonimo/sinonimo/utils/typedef.dart';

abstract class SinonimosLocalDao {
  FutureVoid insertSinonimos(List<PalavraPrincipal> palavras);
  FutureListMapStringDynamic getSinonimos();

  Future<bool> verificarExistenciaDosDados();
}

class SinonimosLocalDaoImpl extends SinonimosLocalDao {
  final String _sinonimosKey = "sinonimos_key_";

  @override
  FutureVoid insertSinonimos(List<PalavraPrincipal> palavras) async {
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
  FutureBool verificarExistenciaDosDados() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs
        .getKeys()
        .where((key) => key.contains(_sinonimosKey))
        .isNotEmpty;
  }
}
