
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/favoris_model.dart';
import '../widgets/destination_card.dart';

class FavorisScreen extends StatelessWidget {
  const FavorisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO récupérer la liste des favoris avec context.watch<FavorisModel>()
    final favoris = context.watch<FavorisModel>().favoris;

    // TODO afficher un message si la liste est vide
    if (favoris.isEmpty) {
      return const Center(
        child: Text('Aucun favori pour le moment.'),
      );
    }

    // TODO afficher les destinations favorites avec DestinationCard
    return ListView.builder(
      itemCount: favoris.length,
      itemBuilder: (context, index) {
        return DestinationCard(destination: favoris[index]);
      },
    );
  }
}
