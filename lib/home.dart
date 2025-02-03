import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'game.dart';
import 'settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final audioPlayer = AudioPlayer();

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    audioPlayer..setAsset( "music.ogg" )..setLoopMode( LoopMode.all );
  }

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
              onPressed: () => showDialog(
                builder: (context) => AlertDialog(
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text( "OK" )
                    )
                  ],
                  content: Text(
                    "Remi Manado is a card game that I play with my family. You have 13 "
                    "cards in your hand and you win by creating sets of cards with the "
                    "same rank and sequences of consecutive cards of the same suit. All "
                    "hands must include at least one sequence. Every card must be part "
                    "of at least one set or sequence. Score as many points as possible "
                    "by playing high ranks and using few discards."
                  ),
                  title: Text( "Tutorial" ),
                ),
                context: context
              ),
              child: Text( "Tutorial" )
            ),
            IconButton(
              onPressed: () => audioPlayer.playing ? audioPlayer.pause() : audioPlayer.play(),
              icon: Icon( Icons.music_note )
            )
          ],
        )
      )
    );
  }
}