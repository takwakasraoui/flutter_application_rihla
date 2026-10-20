# flutter_application_rihla

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Palier2:
Q1:
 Sans Expanded autour de la Column, l'avatar se place selon l'espace occupé par la Column. Il peut se rapprocher du texte, car la Column ne prend plus l'espace restant.
Q2: prenom est final car sa valeur est définie à la création du widget et ne peut plus être modifiée ensuite.
Q3:cs.primary utilise la couleur principale du thème.Colors.teal reste fixe, même si la seedColor change.


Palier3:
Q4:
 Si DecoratedBox est placé en premier, le dégradé apparaît derrière l'image. L'image peut alors cacher le dégradé, car les enfants suivants du Stack sont dessinés au-dessus.
Q5: 
Sans ClipRRect, l'image et le dégradé ne sont plus découpés selon les coins arrondis. Les coins peuvent donc apparaître carrés.
Q6:
Pour laisser de la place au bouton à droite.

Palier4:
Q7:
 Expanded donne à la Column la largeur disponible.
Ainsi, Spacer peut pousser le prix vers la droite.
Q8:
 Il suffit d'ajouter une destination dans le fichier lib/data/destinations.dart.

Palier 5:
Q9: 
Sans setState(), _categorie change en mémoire,
mais l'écran ne se met pas automatiquement à jour.
Q10:
 Le getter _filtrees met à jour la liste selon la catégorie choisie.
Q11:
HeroBanner ne change pas selon la catégorie choisie.

Palier6:
Exercice : ValueKey(d.nom) permet à Flutter d'associer l'état à la bonne carte lors du filtrage.Sans Key, l'état peut être associé à une autre carte

