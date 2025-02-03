import 'package:flutter/material.dart';

import 'game.dart';
import 'settings.dart';
import 'tutorial.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( "Remi Manado" ),
            TextButton(
              onPressed: () => Navigator.of(context).push( MaterialPageRoute (builder: (context) => GameScreen() ) ),
              child: Text( "New Game" )
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push( MaterialPageRoute (builder: (context) => Settings() ) ),
              child: Text( "Settings" )
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push( MaterialPageRoute (builder: (context) => Tutorial() ) ),
              child: Text( "Tutorial" )
            ),
          ],
        )
      )
    );
  }
}