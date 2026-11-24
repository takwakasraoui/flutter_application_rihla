
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Réglages de l'application, mémorisés sur l'appareil.
class ReglagesModel extends ChangeNotifier {
  static const _cle = 'sombre';

  bool _sombre = false;

  bool get sombre => _sombre;

  // Charger le thème enregistré
  Future<void> charger() async {
    final prefs = await SharedPreferences.getInstance();

    _sombre = prefs.getBool(_cle) ?? false;

    notifyListeners();
  }

  // Changer et sauvegarder le thème
  Future<void> basculerTheme() async {
    _sombre = !_sombre;

    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_cle, _sombre);

    notifyListeners();
  }

  // Effacer les données sauvegardées
    Future<void> effacerDonnees() async {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.remove('favoris');
      await prefs.remove('cache_destinations');
      await prefs.remove('date_cache_destinations');
      await prefs.remove(_cle);

      _sombre = false;

      notifyListeners();
    }
}
