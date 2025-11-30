import 'jeu_pendu.dart'; //j'importe la classe
import 'dart:math'; //j'importe les nombres aleatoires avec dart math un truc come ca

void main() {
  print('Bienvenue dans le jeu du Pendu !\n');
  print('Je fais un test de la classe Pendu :\n');

  Pendu jeu = Pendu(); //je cree une instance de la classe Pendu

  //Test de la methode choisirMot
  String motAleatoire = jeu.choisirMot();
  print('Mot aleatoire choisi : $motAleatoire');

  //Test de la methode creerMasque
  String motMasque = jeu.creerMasque(motAleatoire);
  print('Mot masque : $motMasque');

  //Test de la methode verifierLettre
  String lettreTest = 'a';
  bool resultatVerification = jeu.verifierLettre(lettreTest, motAleatoire);
  print(
    'La lettre $lettreTest est dans le mot ? \n C\'est $resultatVerification',
  );
}
