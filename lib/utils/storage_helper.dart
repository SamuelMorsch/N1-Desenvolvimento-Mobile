import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/compromisso.dart';

class StorageHelper {
  static Future<void> saveCompromissos(Map<DateTime, List<Compromisso>> compromissos) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> compromissosMap = {};

    compromissos.forEach((key, value) {
      compromissosMap[key.toIso8601String()] = value.map((comp) => {
        'descricao': comp.descricao,
        'hora': comp.hora,
        'data': comp.data.toIso8601String(), // Salvar a data
      }).toList();
    });

    await prefs.setString('compromissos', jsonEncode(compromissosMap));
  }

  static Future<Map<DateTime, List<Compromisso>>> loadCompromissos() async {
    final prefs = await SharedPreferences.getInstance();
    final String? compromissosString = prefs.getString('compromissos');

    if (compromissosString == null) return {};

    final Map<String, dynamic> compromissosMap = jsonDecode(compromissosString);
    Map<DateTime, List<Compromisso>> compromissos = {};

    compromissosMap.forEach((key, value) {
      DateTime date = DateTime.parse(key);
      compromissos[date] = (value as List).map((comp) => Compromisso(
        descricao: comp['descricao'],
        hora: comp['hora'],
        data: DateTime.parse(comp['data']), // Carregar a data
      )).toList();
    });

    return compromissos;
  }
}
