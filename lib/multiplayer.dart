import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () {},
          child: Text( "Create game" )
        ),
        TextButton(
          onPressed: () {},
          child: Text( "Join game" )
        )
      ],
      content: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Name"
            )
          ),
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Game code"
            )
          )
        ]
      ),
      title: Text( "Multiplayer" )
    );
  }
}