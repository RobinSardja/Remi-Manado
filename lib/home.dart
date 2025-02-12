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
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => GameScreen(
                    audioPlayer: audioPlayer,
                  )
                )
              ),
              child: Text( "Singleplayer" )
            ),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Settings(
                    audioPlayer: audioPlayer
                  )
                )
              ),
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
                    "Remi Manado is a card game that I play with my family. "
                    "You have 13 cards in your hand and you win by creating "
                    "sets of cards of the same rank or runs of sequential "
                    "cards with the same suit. Every hand must include at "
                    "least one run and every card must be part of a set or a "
                    "run. Score as many points as possible by playing high "
                    "ranks and using few discards as fast as you can."
                  ),
                  title: Text( "Tutorial" ),
                ),
                context: context
              ),
              child: Text( "Tutorial" )
            )
          ]
        )
      )
    );
  }
}