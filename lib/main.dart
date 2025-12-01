import 'jeu_pendu.dart'; //j'importe la classe
import 'dart:math'; //j'importe les nombres aleatoires avec dart math un truc come ca

import 'package:flutter/material.dart';
import 'screens/jeu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jeu du Pendu',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      debugShowCheckedModeBanner: false,
      home: const JeuScreen(),
    );
  }
}
