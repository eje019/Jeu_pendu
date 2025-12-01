import 'dart:math';

//La classe principale du jeu
class Pendu {
  //Variables d'etat du jeu
  String motSecret = ''; //le mot a deviner

  String motMasque = ''; //le mot masqué avec des _

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

  //La fonction qui cree le masque du mot avec des _
  String creerMasque(String mot) {
    String masque = '';
    for (int i = 0; i < mot.length; i++) {
      masque += '_';
    }
    return masque;
  }

  //La fonction qui verifie si une lettre est dans le mot triuve aleaoirement
  bool verifierLettre(String lettre, String mot) {
    return mot.contains(lettre);
  }

  //la fonction qui revele les positions d'une lettre dans le masque
  String revelerLettre(String lettre, String mot, String masque) {
    //ON CONVERTIT LE MASQUE EN LISTE DE CARACTERES
    List<String> carac = masque.split('');

    //ON PARCOURS CHAQUE POSITION DU MOt
    for (int i = 0; i < mot.length; i++) {
      if (mot[i] == lettre) {
        carac[i] = lettre;
      }
    }
    // si c'est bon on reconvertis la liste en String
    return carac.join('');
  }

  //la fonction ajoutererreur qui fait +1 erreur -1 vie
  void ajouterErreur() {
    vies = vies - 1;
    if (vies < 0) {
      vies = 0;
    }
  }

  //La fonction deja jouée qui verife si une lettre a deja ete proposee
  //on avait deja declare une v ariable lettreJouees de type listre qui est censee stocker les lettre joiuee dans un tablea vide de base
  bool dejaJouee(String lettre) {
    return lettresJouees.contains(lettre);
  }

  //la fonction qui retourne le nombre de vies restantes
  int getVieRestantes() {
    return vies;
  }
}
