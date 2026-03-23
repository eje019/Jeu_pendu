Jeu du Pendu - Version Dart Console
Un jeu classique où vous devez deviner un mot lettre par lettre avant que le bonhomme ne soit complètement pendu !

STRUCTURE DU PROJET
pendu_console/
├── jeu_pendu.dart    # Toutes les fonctions du jeu
├── main.dart         # Programme principal
└── README.md         # Ce fichier

COMMENT DÉMARRER
1. INSTALLATION
# 1.  Dart est installé
dart --version

# 2. Créer un dossier pour ton projet
mkdir pendu_console
cd pendu_console

# 3. Créer le fichier pubspec.yaml
echo "name: pendu_console
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  dart:math
  dart:io" > pubspec.yaml
2. EXÉCUTION
bash
# Place les fichiers .dart dans le dossier
# Puis exécuter :
dart run main.dart


# LOGIQUE DU JEU - EXPLICATION DÉTAILLÉE
MODULE 1 : GESTION DU MOT SECRET
Fonction 1 : choisirMot()
dart
String choisirMot() {
  // Liste de mots disponibles
  List<String> mots = ['TABLE', 'CHAISE', 'ORDINATEUR'];
  
  // Choisir un index aléatoire
  Random random = Random();
  int index = random.nextInt(mots.length);
  
  // Retourner le mot à cet index
  return mots[index];
}
Explication : On a plusieurs mots, on en choisit un au hasard.

Fonction 2 : creerMasque(mot)
dart
String creerMasque(String mot) {
  String masque = "";
  for (int i = 0; i < mot.length; i++) {
    masque += "_";
  }
  return masque;
}
Explication : Transforme "TABLE" → "_____". Chaque _ représente une lettre cachée.

Fonction 3 : verifierLettre(lettre, mot)
dart
bool verifierLettre(String lettre, String mot) {
  return mot.contains(lettre);
}
Explication : Vérifie si la lettre proposée est dans le mot.
Exemple : "T" dans "TABLE" → true, "Z" dans "TABLE" → false

Fonction 4 : revelerLettres(lettre, masque, mot)
dart
String revelerLettres(String lettre, String masque, String mot) {
  List<String> caracteres = masque.split('');
  
  for (int i = 0; i < mot.length; i++) {
    if (mot[i] == lettre) {
      caracteres[i] = lettre;
    }
  }
  
  return caracteres.join('');
}
Explication : Révèle la lettre aux bonnes positions.
Exemple : Masque "_____", lettre "T", mot "TABLE" → "T____"

👤 MODULE 2 : SUIVI DU JOUEUR
Fonction 5 : ajouterErreur()
dart
void ajouterErreur() {
  vies = vies - 1;
  if (vies < 0) vies = 0;
}
Explication : Réduit le compteur de vies quand le joueur se trompe. De 6 → 5 → 4...

Fonction 6 : dejaJouee(lettre)
dart
bool dejaJouee(String lettre) {
  return lettresJouees.contains(lettre);
}
Explication : Évite que le joueur propose la même lettre deux fois.
Exemple : Si "A" déjà essayée → true

Fonction 7 : getViesRestantes()
dart
int getViesRestantes() {
  return vies;
}
Explication : Donne simplement le nombre de vies restantes.

🎮 MODULE 3 : LOGIQUE CENTRALE DU JEU
Fonction 8 : nouvellePartie()
dart
void nouvellePartie() {
  motSecret = choisirMot();      // Nouveau mot
  motMasque = creerMasque(motSecret); // Masque vide
  vies = 6;                      // Réinitialise vies
  lettresJouees.clear();         // Vide la liste
}
Explication : Réinitialise tout pour une nouvelle partie.

Fonction 9 : traiterProposition(lettre)
dart
Map<String, dynamic> traiterProposition(String lettre) {
  // Étape 1 : Vérifier si déjà jouée
  if (dejaJouee(lettre)) {
    return {'success': false, 'message': 'Déjà essayée'};
  }
  
  // Étape 2 : Ajouter à la liste
  lettresJouees.add(lettre);
  
  // Étape 3 : Vérifier si dans le mot
  if (verifierLettre(lettre, motSecret)) {
    // Bonne lettre
    motMasque = revelerLettres(lettre, motMasque, motSecret);
    return {'success': true, 'message': 'Bonne lettre!'};
  } else {
    // Mauvaise lettre
    ajouterErreur();
    return {'success': false, 'message': 'Mauvaise lettre'};
  }
}
Explication : CŒUR DU JEU - Gère tout ce qui se passe quand le joueur propose une lettre.

Fonction 10 : aGagne()
dart
bool aGagne() {
  return motMasque == motSecret;
}
Explication : Vérifie si le joueur a trouvé toutes les lettres (plus de _).

Fonction 11 : aPerdu()
dart
bool aPerdu() {
  return vies <= 0;
}
Explication : Vérifie si le joueur n'a plus de vies.

🎨 MODULE 4 : AFFICHAGE
Fonction 12 : afficherMot(masque)
dart
String afficherMot(String masque) {
  return masque.split('').join(' ');
}
Explication : Formate pour mieux lire : "BANANE" → "B A N A N E"

Fonction 13 : afficherPendu(erreurs)
dart
String afficherPendu(int erreurs) {
  // Dessins ASCII qui évoluent avec les erreurs
  List<String> etapes = [ /* 7 dessins différents */ ];
  return etapes[erreurs];
}
Explication : Affiche le dessin du pendu qui se complète à chaque erreur.

Fonction 14 : demanderLettreConsole()
dart
String demanderLettreConsole() {
  print("👉 Entrez une lettre: ");
  String? input = stdin.readLineSync();
  return input?[0].toUpperCase() ?? "";
}
Explication : Demande et récupère la lettre du joueur dans la console.

🔄 DÉROULEMENT D'UNE PARTIE
text
1. Début : Vies = 6, Mot = "TABLE", Masque = "_____"
2. Joueur propose "T" → Bonne lettre → Masque = "T____"
3. Joueur propose "Z" → Mauvaise lettre → Vies = 5
4. Joueur propose "A" → Bonne lettre → Masque = "TA___"
5. Continue jusqu'à...
   - Victoire : Masque = "TABLE" → BRAVO !
   - Défaite : Vies = 0 → PERDU !
💡 CONCEPTS DART IMPORTANTS
1. LES VARIABLES
dart
String texte = "Bonjour";  // Chaîne de caractères
int nombre = 5;            // Nombre entier
bool vraiOuFaux = true;    // Vrai ou Faux
List<String> liste = ["A", "B"]; // Liste
2. LES FONCTIONS
dart
// Déclaration
type nomFonction(paramètres) {
  // Code
  return valeur;
}

// Exemple
int addition(int a, int b) {
  return a + b;
}
3. LES CONDITIONS
dart
if (condition) {
  // Si vrai
} else {
  // Si faux
}
4. LES BOUCLES
dart
// Boucle for
for (int i = 0; i < 5; i++) {
  print(i); // 0, 1, 2, 3, 4
}

// Boucle while
while (vies > 0) {
  // Continue tant que vies > 0
}
