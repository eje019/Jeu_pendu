import 'package:flutter/material.dart';
import '../jeu_pendu.dart';
import '../widgets/clavier_avance.dart';

class JeuScreen extends StatefulWidget {
  const JeuScreen({Key? key}) : super(key: key);

  @override
  _JeuScreenState createState() => _JeuScreenState();
}

class _JeuScreenState extends State<JeuScreen> {
  // Instance de notre jeu
  late Pendu jeu;

  // Variables pour suivre l'état
  String message = "Bienvenue !";
  bool partieEnCours = true;

  @override
  void initState() {
    super.initState();
    // Initialiser une nouvelle partie
    _demarrerPartie();
  }

  void _demarrerPartie() {
    setState(() {
      jeu = Pendu();
      jeu.nouvellePartie();
      message = "Devinez le mot !";
      partieEnCours = true;
    });
  }

  void _proposerLettre(String lettre) {
    if (!partieEnCours) return;

    setState(() {
      var resultat = jeu.traiterProposition(lettre);
      message = resultat['message'];

      // Vérifier si la partie est terminée
      if (jeu.aGagne()) {
        message = "🎉 FÉLICITATIONS ! Vous avez gagné !";
        partieEnCours = false;
      } else if (jeu.aPerdu()) {
        message = "💀 PERDU ! Le mot était : ${jeu.motSecret}";
        partieEnCours = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu du Pendu'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _demarrerPartie,
            tooltip: 'Nouvelle partie',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple.shade100, Colors.white],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. COMPTEUR DE VIES
              _buildCompteurVies(),

              const SizedBox(height: 20),

              // 2. DESSIN DU PENDU
              _buildDessinPendu(),

              const SizedBox(height: 30),

              // 3. MOT À DEVINER
              _buildMotMasque(),

              const SizedBox(height: 20),

              // 4. MESSAGE
              _buildMessage(),

              const SizedBox(height: 20),

              // 5. LETTRES DÉJÀ ESSAYÉES
              _buildLettresEssayees(),

              const SizedBox(height: 30),

              // 6. CLAVIER (sera ajouté après)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ClavierAvance(
                    onLettreTap: _proposerLettre,
                    lettresJouees: jeu.lettresJouees,
                    motSecret: jeu.motSecret,
                    partieEnCours: partieEnCours,
                  ),
                ),
              ),

              // 7. BOUTON NOUVELLE PARTIE
              if (!partieEnCours) _buildBoutonRejouer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompteurVies() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Vies restantes :',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(
                jeu.vies,
                (index) =>
                    const Icon(Icons.favorite, color: Colors.red, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDessinPendu() {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            jeu.afficherPendu(6 - jeu.vies), // 6 vies initiales
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMotMasque() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            jeu.afficherMot(jeu.motMasque),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 3.0,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildLettresEssayees() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lettres essayées :',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: jeu.lettresJouees.map((lettre) {
            return Chip(
              label: Text(
                lettre,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              backgroundColor: jeu.motSecret.contains(lettre)
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              side: BorderSide(
                color: jeu.motSecret.contains(lettre)
                    ? Colors.green
                    : Colors.red,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildBoutonRejouer() {
    return ElevatedButton(
      onPressed: _demarrerPartie,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        'NOUVELLE PARTIE',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
