import 'dart:convert';
 
import 'package:http/http.dart' as http;
 
import '../config/api_config.dart';
import '../models/destination.dart';
import '../models/reservation.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class ApiService {
  static const _cleCache = 'cache_destinations';
  static const _cleDateCache = 'date_cache_destinations';
  static String? dateDernierChargement;
  static bool depuisCache = false;
  static Uri _url(String chemin) => Uri.parse('${ApiConfig.baseUrl}$chemin');

  static List<Destination> _decoder(String corps) => 
  (jsonDecode(corps) as List).map((e) => Destination.fromJson(e)).toList();
 
  static Future<List<Destination>> getDestinations() async {
    final prefs = await SharedPreferences.getInstance();

      try {
        final reponse = await http
            .get(_url('/destinations'))
            .timeout(ApiConfig.timeout);

        if (reponse.statusCode != 200) {
          throw Exception('Erreur ${reponse.statusCode}');
        }

        final corps = utf8.decode(reponse.bodyBytes);

        // Sauvegarder les destinations
        await prefs.setString(_cleCache, corps);

        // Sauvegarder la date du dernier chargement réussi
        final date = DateTime.now().toIso8601String();
        await prefs.setString(_cleDateCache, date);
        dateDernierChargement = date;

        depuisCache = false;
        return _decoder(corps);

      } catch (e) {
        final cache = prefs.getString(_cleCache);

        if (cache == null) {
          rethrow;
        }

        // Récupérer la date sauvegardée
        dateDernierChargement = prefs.getString(_cleDateCache);

        depuisCache = true;
        return _decoder(cache);
      }
    }

    static Future<String> creerReservation(Reservation reservation) async {
      final reponse = await http
          .post(
            _url('/reservations'),
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(reservation.toJson()),
          )
          .timeout(ApiConfig.timeout);

      if (reponse.statusCode != 201) {
        throw Exception('Erreur lors de la réservation : ${reponse.statusCode}');
      }

      final Map<String, dynamic> creee =
          jsonDecode(utf8.decode(reponse.bodyBytes));

      return creee['id'].toString();
    }

}