import 'package:flutter/material.dart';
import 'package:flutter_application_rihla/models/destination.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
class HomeScreen extends StatefulWidget { 
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout';
  List<Destination> get _filtrees {
    if (_categorie == 'Tout') {
      return destinations;
    }

    return destinations
        .where((d) => d.categorie == _categorie)
        .toList();
  }




  @override Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        child: ListView( padding: const EdgeInsets.all(20),
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
          HeroBanner(destination: destinations.first),
          for (final d in _filtrees)
            DestinationCard(destination: d),
        
        ], 
        ),
        ), ); 
    }
}