import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class Settings extends StatefulWidget {
  const Settings({
    required this.audioPlayer,
    super.key
  });

  final AudioPlayer audioPlayer;

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( "Settings" )
      ),
      body: Center(
        child: Column(
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
      )
    );
  }
}