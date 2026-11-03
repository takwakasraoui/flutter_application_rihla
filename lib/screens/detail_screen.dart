
import 'package:flutter/material.dart';
import '../models/destination.dart';
import '../widgets/favorite_button.dart';
import 'reservation_screen.dart';
import '../models/reservation.dart';
class DetailScreen extends StatefulWidget {
  final Destination destination;

  const DetailScreen({
    super.key,
    required this.destination,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int _voyageurs = 1;



  Future<void> _reserver() async {
        final reservation = await Navigator.push<Reservation>(
          context,
          MaterialPageRoute(
            builder: (context) => ReservationScreen(
              destination: widget.destination,
              voyageurs: _voyageurs,
            ),
          ),
        );

        // TODO 3 : si aucune réservation n'est renvoyée
        if (reservation == null) return;

        // TODO 4 : vérifier que l'écran existe toujours
        if (!mounted) return;

        await showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            title: const Text('Réservation confirmée'),
            content: Text(
              'Nom : ${reservation.nom}\n'
              'Destination : ${reservation.destination.nom}\n'
              'Voyageurs : ${reservation.voyageurs}\n'
              'Formule : ${reservation.formule}\n'
              'Total : ${reservation.total} DT\n'
              'E-mail : ${reservation.email}',
            ),
            actions: [
              FilledButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Parfait'),
              ),
            ],
          ),
        );
      }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final destination = widget.destination;
    final total = destination.prix * _voyageurs;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [
            // Image et boutons superposés
            Stack(
              children: [
              Hero(
                tag: 'image-${widget.destination.nom}',
                child: Image.asset(
                  destination.image,
                  height: 340,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: const FavoriteButton(),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom, région et note
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              destination.nom,
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              destination.region,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        avatar: const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18,
                        ),
                        label: Text('${destination.note}'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Les trois tuiles
                  Row(
                    children: [
                      Expanded(
                        child: _tuile(
                          context,
                          Icons.calendar_month,
                          'Durée',
                          destination.duree,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _tuile(
                          context,
                          Icons.landscape,
                          'Type',
                          destination.categorie,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _tuile(
                          context,
                          Icons.groups,
                          'Groupe',
                          'Petit groupe',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'À propos',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    destination.description,
                    style: theme.textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 24),

                  // Nombre de voyageurs
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Voyageurs',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: _voyageurs > 1
                            ? () {
                                setState(() {
                                  _voyageurs--;
                                });
                              }
                            : null,
                        icon: const Icon(Icons.remove),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          '$_voyageurs',
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      IconButton.outlined(
                        onPressed: () {
                          setState(() {
                            _voyageurs++;
                          });
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Barre de réservation en bas
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total',
                      style: theme.textTheme.bodyMedium,
                    ),
                    Text(
                      '$total DT',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: cs.primary,
                      ),
                    ),
                  ],
                ),
              ),
              FilledButton(
                onPressed: _reserver,
                child: const Text('Réserver'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tuile(
    BuildContext context,
    IconData icone,
    String titre,
    String valeur,
  ) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Icon(icone, color: cs.primary),
          const SizedBox(height: 8),
          Text(
            titre,
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
          Text(
            valeur,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
