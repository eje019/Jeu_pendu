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
  String lettreTest = 'A';
  bool resultatVerification = jeu.verifierLettre(lettreTest, motAleatoire);
  print(
    'La lettre $lettreTest est dans le mot ? \n C\'est $resultatVerification',
  );

  //Test de la methode revelerLettre
  String motRevele = jeu.revelerLettre(lettreTest, motAleatoire, motMasque);
  print('Mot avec la lettre $lettreTest revelee : $motRevele');
}
