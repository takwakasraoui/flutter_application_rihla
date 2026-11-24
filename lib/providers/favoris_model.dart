
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/destination.dart';

class FavorisModel extends ChangeNotifier {
  static const _cle = 'favoris';

  final Map<String, Destination> _favoris = {};

  bool estFavori(Destination d) => _favoris.containsKey(d.id);

  List<Destination> get favoris => List.unmodifiable(_favoris.values);

  int get nombre => _favoris.length;

  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();

    final textes = prefs.getStringList(_cle) ?? [];

    for (final texte in textes) {
      final json = jsonDecode(texte);
      final destination = Destination.fromJson(json);
      _favoris[destination.id] = destination;
    }
    

    notifyListeners();
  }

  Future<void> _sauvegarder() async {
    final prefs = await SharedPreferences.getInstance();

    final textes = _favoris.values
        .map((d) => jsonEncode(d.toJson()))
        .toList();

    await prefs.setStringList(_cle, textes);
  }

  bool basculer(Destination d) {
    final ajoute = _favoris.remove(d.id) == null;

    if (ajoute) _favoris[d.id] = d;

    _sauvegarder();

    notifyListeners();

    return ajoute;
  }

  // Vider les favoris
Future<void> effacer() async {
  final prefs = await SharedPreferences.getInstance();

  _favoris.clear();

  await prefs.remove(_cle);

  notifyListeners();
}
}
