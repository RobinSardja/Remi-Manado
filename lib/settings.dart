import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class GameSettings extends StatefulWidget {
  const GameSettings({
    required this.audioPlayer,
    super.key
  });

  final AudioPlayer audioPlayer;

  @override
  State<GameSettings> createState() => _GameSettingsState();
}

class _GameSettingsState extends State<GameSettings> {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () =>
              widget.audioPlayer.playing ? 
              widget.audioPlayer.pause() :
              widget.audioPlayer.play(),
            child: Text( "Play music" )
          )
        ]
      )
    );
  }
}