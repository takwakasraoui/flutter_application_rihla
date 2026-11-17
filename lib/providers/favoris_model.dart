import 'package:flutter/foundation.dart';

import '../models/destination.dart';

/// TP6 — Partie 2.2 : favoris partagés par tous les écrans.
///
/// Laissez Copilot compléter les TODO UN PAR UN (Tab pour accepter,
/// Échap pour rejeter, Alt+] pour voir une autre proposition).
/// Avant d'accepter, vérifiez :
///   - la clé est d.id (et non d.nom) ;
///   - notifyListeners() est appelé dans basculer ;
///   - la liste exposée est en lecture seule (List.unmodifiable).
/// Notez chaque décision dans votre journal IA.
class FavorisModel extends ChangeNotifier {
  // favoris rangés par id : Map<String, Destination>
  final Map<String, Destination> _favoris = {};

  bool estFavori(Destination d) => _favoris.containsKey(d.id);

  List<Destination> get favoris => List.unmodifiable(_favoris.values);

  int get nombre => _favoris.length;

  // TODO basculer(Destination d) : ajoute ou retire,
  //      prévient les écouteurs, renvoie true si ajouté
  bool basculer(Destination d) {
    final ajoute = !_favoris.containsKey(d.id);
    if (ajoute) {
      _favoris[d.id] = d;
    } else {
      _favoris.remove(d.id);
    }
    notifyListeners();
    return ajoute;
  }
}
