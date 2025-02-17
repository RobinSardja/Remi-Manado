import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'settings.dart';

class Multiplayer extends StatefulWidget {
  const Multiplayer({
    super.key,
    required this.audioPlayer
  });

  final AudioPlayer audioPlayer;

  @override
  State<Multiplayer> createState() => _MultiplayerState();
}

class _MultiplayerState extends State<Multiplayer> {
 
  @override
  Widget build( BuildContext context ) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Settings(
                  audioPlayer: widget.audioPlayer 
                )
              )
            ),
            icon: Icon( Icons.settings )
          )
        ],
        centerTitle: true,
        title: Text( "Remi Manado" )
      ),
      body: Placeholder()
    );
  }
}