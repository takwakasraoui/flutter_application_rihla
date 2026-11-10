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

Palier2:
Q1:
Oui, le filtre reste actif car HomeScreen reste dans la pile. Navigator.pop revient simplement à l'écran précédent.
Q2:
DetailScreen reçoit destination avec un paramètre.C'est le passage de paramètres utilisé au TP3.
Q3:
Sans clipBehavior, les coins arrondis ne découpent plus correctement le contenu qui dépasse de la carte.

Palier3:
Q1:
validate() vérifie tous les champs. Elle renvoie true si tout est valide, sinon false.
Q2:
inputFormatters : contrôle la saisie pendant que l'utilisateur écrit (chiffres uniquement, maximum 8 chiffres).
validator : vérifie si la valeur saisie est correcte lorsque le formulaire est validé et affiche un message d'erreur si nécessaire.
Q3:
dispose() libère les ressources des contrôleurs pour éviter les fuites de mémoire.
Palier4:
Q1:
Parce que l'utilisateur doit choisir une date dans le calendrier. Sans readOnly, il pourrait saisir manuellement un texte ou une date invalide.
Q2:
Parce que _total est un getter : il recalcule sa valeur à partir de _prixParPersonne et du nombre de voyageurs chaque fois qu'on y accède. setState provoque la reconstruction de l'écran.

Palier5:
Q1:
reservation vaut null, car Navigator.pop(context) ferme le formulaire sans retourner de résultat.
Q2:
VS Code affiche un avertissement use_build_context_synchronously. Il signifie qu'on utilise context après un await, alors que le widget peut avoir été supprimé. mounted vérifie que le widget existe toujours avant d'utiliser context.
Q3:
Une boîte de dialogue est aussi une route dans la pile de navigation. Navigator.pop(context) permet donc de la fermer et de revenir à l'écran précédent.


TP5:


Palier0:
Q1:Il renvoie le code 404 Not Found, qui appartient à la famille des erreurs côté client. Cela signifie que la destination demandée n'existe pas.
Q2:C'est le serveur json-server qui a généré automatiquement l'ID de la réservation.
Q3:GET sert à récupérer des données, donc elle n'a pas besoin de corps. POST sert à envoyer de nouvelles données au serveur, donc elle contient un corps avec les informations à ajouter.

