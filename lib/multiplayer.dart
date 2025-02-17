import 'package:cloud_firestore/cloud_firestore.dart';
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

  final codeController = TextEditingController();
  final nameController = TextEditingController();
  Widget createGameChild = Text( "Create game" );
  Widget joinGameChild = Text( "Join game" );

  Future<bool> doesGameExist( String code ) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("games")
        .doc(code)
        .get();

      return snapshot.exists;
    } catch(e) {
      invalidSnackBar( "Error connecting to games" );
      return false;
    }
  }

  void invalidSnackBar( String content ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction( label: "OK", onPressed: () {} ),
        behavior: SnackBarBehavior.floating,
        content: Text( content )
      )
    );
  }
 
  @override
  Widget build( BuildContext context ) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => showDialog(
              builder: (context) => GameSettings(
                audioPlayer: widget.audioPlayer
              ),
              context: context
            ),
            icon: Icon( Icons.settings )
          )
        ],
        centerTitle: true,
        title: Text( "Remi Manado" )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: "Code"
              )
            ),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name"
              )
            ),
            TextButton(
              onPressed: () async {
                setState( () =>
                  createGameChild = CircularProgressIndicator.adaptive()
                );
                if( codeController.text.isEmpty ) {
                  invalidSnackBar( "Please enter a code" );
                } else if( nameController.text.isEmpty ) {
                  invalidSnackBar( "Please enter a name" );
                } else if( await doesGameExist( codeController.text ) ) {
                  invalidSnackBar( "Game already exists with this code" );
                }
                setState( () => createGameChild = Text( "Create game" ) );
              },
              child: createGameChild
            ),
            TextButton(
              onPressed: () async {
                setState( () =>
                  joinGameChild = CircularProgressIndicator.adaptive()
                );
                if( codeController.text.isEmpty ) {
                  invalidSnackBar( "Please enter a code" );
                } else if( nameController.text.isEmpty ) {
                  invalidSnackBar( "Please enter a name" );
                } else if( !( await doesGameExist( codeController.text ) ) ) {
                  invalidSnackBar( "No games exist with this code" );
                }
                setState( () => joinGameChild = Text( "Join game" ) );
              },
              child: joinGameChild
            ),
          ]
        )
      )
    );
  }
}