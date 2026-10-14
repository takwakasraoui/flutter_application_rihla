import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/hero_banner.dart';
import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/section_title.dart';
class HomeScreen extends StatelessWidget { 
  const HomeScreen({super.key});
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
          const SectionTitle(
            titre: 'Populaires',
            action: 'Voir tout',
          ),
          HeroBanner(destination: destinations.first),
          for (final d in destinations)
            DestinationCard(destination: d),
        
        ], 
        ),
        ), ); 
    }
    
    
    
    
  }