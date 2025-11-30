import 'dart:math';

//La classe principale du jeu
class Pendu {
  //Variables d'etat du jeu
  String motSecret = ''; //le mot a deviner

  String motMasque = ''; //le mot masque avec des _

  int vies = 6; //nombre de vies restantes

  List<String> lettresJouees = []; //les lettres deja jouees

  List<String> mots = ['ESGIS', 'CHAISE', 'ORDINATEUR', 'PROGRAMMATION'];

  //fonction qui choisit un mot aleatoire
  String choisirMot() {
    //j'importe les nombres aleatoires avec dart math un truc come ca

    //je cre un generateur de nombres aleatoires
    Random rnd = Random();

    int indexAleatoire = rnd.nextInt(mots.length);

    return mots[indexAleatoire];

    //je veux afficher le mot aleatoire la
    //c'est simple quanf on fait fait mots[1] par ex on affiche le premier mot
    //la maintenant la je veux un index aleatoire (le 1 la) entre 0 et la longueur de la liste des mots moins 1
    //et c'est ce index la que je donne a la liste mots et quiva me retourner un mot aleatoire
  }

  String creerMasque(String mot) {
    String masque = '';
    for (int i = 0; i < mot.length; i++) {
      masque += '_';
    }
    return masque;
  }

  bool verifierLettre(String lettre, String mot) {
    return mot.contains(lettre);
  }
}
