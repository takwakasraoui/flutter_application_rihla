import 'package:flutter/material.dart';
import 'package:flutter_application_rihla/models/destination.dart';
import 'package:provider/provider.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
import '../services/api_service.dart';
import 'favoris_screen.dart';
import '../providers/favoris_model.dart';

class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout';
  int _onglet = 0;
  late Future<List<Destination>> _futurDestinations;
  
  List<Destination> _filtrer(List<Destination> toutes) {
  if (_categorie == 'Tout') {
    return toutes;
  }

  return toutes
      .where((d) => d.categorie == _categorie)
      .toList();
}

   @override
  void initState() {
    super.initState();
    // TODO 1 : lancer la requête et stocker le Future
    _futurDestinations = ApiService.getDestinations();
  }

  Future<void> _recharger() async {
  final futur = ApiService.getDestinations();
  setState(() {
    _futurDestinations = futur;   // FutureBuilder écoute le nouveau Future
  });
  try {
    await futur;                  // RefreshIndicator attend la fin
  } catch (_) {}                  // l'erreur est affichée par FutureBuilder
}




  @override Widget build(BuildContext context) {
    // TODO : récupérer le nombre de favoris avec context.watch<FavorisModel>()
    final nombreFavoris = context.watch<FavorisModel>().nombre;
        return Scaffold(
        body: switch (_onglet) {
            0 => _construireExplorer(),
            1 => const FavorisScreen(),
            _ => const Center(
                child: Text('Bientôt disponible'),
              ),
          },
        bottomNavigationBar: NavigationBar(
          selectedIndex: _onglet,
          onDestinationSelected: (index) {
            setState(() {
              _onglet = index;
            });
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.explore_outlined),
              selectedIcon: Icon(Icons.explore),
              label: 'Explorer',
            ),
             NavigationDestination(
                icon: Badge(
                  isLabelVisible: nombreFavoris > 0,
                  label: Text('$nombreFavoris'),
                  child: Icon(Icons.favorite_border),
                ),
                selectedIcon: Badge(
                  isLabelVisible: nombreFavoris > 0,
                  label: Text('$nombreFavoris'),
                  child: Icon(Icons.favorite),
                ),
                label: 'Réservations',
              ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      );
    }

    Widget _construireExplorer() {
  return FutureBuilder<List<Destination>>(
    future: _futurDestinations,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError) {
        return ErreurReseau(
          message: snapshot.error.toString(),
          onReessayer: () {
            setState(() {
              _futurDestinations = ApiService.getDestinations();
            });
          },
        );
      }

      final destinations = snapshot.data ?? [];

      return RefreshIndicator(
        onRefresh: _recharger,
        child: _construireAccueil(destinations),
      );
    },
  );
}

    Widget _construireAccueil(List<Destination> destinations) {
    return  SafeArea( 
        child: ListView( padding: const EdgeInsets.all(20),physics: const AlwaysScrollableScrollPhysics(),
        children: [ 
          //const Text('Takwa'),
          const HomeHeader(prenom: 'takwa'),
          const SizedBox(height: 20),
          const SearchBox(),
          const SizedBox(height: 20),
          const SectionTitle(titre: 'Catégories'),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final c in categories)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(c),
                      selected: _categorie == c,
                      onSelected: (_) {
                        setState(() {
                          _categorie = c;
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const SectionTitle(
            titre: 'Populaires',
            action: 'Voir tout',
          ),
          if (destinations.isNotEmpty)
            HeroBanner(destination: destinations.first),
              for (final d in _filtrer(destinations))
                  DestinationCard(
                    key: ValueKey(d.id),
                    destination: d,
                  ),
        
        ], 
        ),
    );
    
    
    }


}

class ErreurReseau extends StatelessWidget {
  final String message;
  final VoidCallback onReessayer;
 
  const ErreurReseau({super.key, required this.message, required this.onReessayer});
 
  @override
  Widget build(BuildContext context) {
    // TODO 4 : Column centrée : Icon(Icons.cloud_off) en couleur d'erreur,
    //          le message, « Vérifiez que json-server est lancé. »,
    //          et un FilledButton.tonalIcon « Réessayer » qui appelle onReessayer
    return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_off,
          size: 60,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(message),
        const SizedBox(height: 8),
        const Text('Vérifiez que json-server est lancé.'),
        const SizedBox(height: 16),
        FilledButton.tonalIcon(
          onPressed: onReessayer,
          icon: const Icon(Icons.refresh),
          label: const Text('Réessayer'),
        ),
      ],
    ),
  );
  }
}