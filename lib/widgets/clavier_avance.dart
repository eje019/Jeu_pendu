// lib/widgets/clavier_avance.dart
import 'package:flutter/material.dart';

class ClavierAvance extends StatelessWidget {
  final Function(String) onLettreTap;
  final List<String> lettresJouees;
  final String motSecret;
  final bool partieEnCours;

  const ClavierAvance({
    Key? key,
    required this.onLettreTap,
    required this.lettresJouees,
    required this.motSecret,
    required this.partieEnCours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> toutesLettres = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.2,
      ),
      itemCount: toutesLettres.length,
      itemBuilder: (context, index) {
        String lettre = toutesLettres[index];
        bool dejaJouee = lettresJouees.contains(lettre);
        bool estDansMot = motSecret.contains(lettre);

        return _buildBoutonLettreAvance(
          lettre,
          dejaJouee,
          estDansMot,
          partieEnCours,
        );
      },
    );
  }

  Widget _buildBoutonLettreAvance(
    String lettre,
    bool dejaJouee,
    bool estDansMot,
    bool partieEnCours,
  ) {
    Color couleurFond;
    Color couleurBordure;
    bool desactive = dejaJouee || !partieEnCours;

    if (!dejaJouee) {
      couleurFond = Colors.white;
      couleurBordure = Colors.deepPurple;
    } else if (estDansMot) {
      couleurFond = Colors.green.shade100;
      couleurBordure = Colors.green;
    } else {
      couleurFond = Colors.red.shade100;
      couleurBordure = Colors.red;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: couleurFond,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: couleurBordure, width: 2),
        boxShadow: [
          if (!desactive)
            BoxShadow(
              color: Colors.deepPurple.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: desactive ? null : () => onLettreTap(lettre),
          splashColor: Colors.deepPurple.withOpacity(0.3),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lettre,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: desactive ? Colors.grey : couleurBordure,
                  ),
                ),
                if (dejaJouee)
                  Icon(
                    estDansMot ? Icons.check : Icons.close,
                    size: 14,
                    color: estDansMot ? Colors.green : Colors.red,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
