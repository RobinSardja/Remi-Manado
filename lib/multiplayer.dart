import 'package:cloud_firestore/cloud_firestore.dart';
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

  final codeController = TextEditingController();
  final nameController = TextEditingController();

  Future<bool> doesGameExist( String code ) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("games")
        .doc(code)
        .get();

      return snapshot.exists;
    } catch(e) {
      return false;
    }
  }

  void invalidInputDialog( String title ) {
    showDialog(
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text( "OK" )
          )
        ],
        title: Text( title ),
      ),
      context: context
    );
  }
 
  @override
  Widget build( BuildContext context ) {
    return AlertDialog(
      actions: [
        TextButton(
          onPressed: () async {
            if( codeController.text.isEmpty ) {
              invalidInputDialog( "Please enter a code" );
            } else if( nameController.text.isEmpty ) {
              invalidInputDialog( "Please enter a name" );
            } else if( await doesGameExist( codeController.text ) ) {
              invalidInputDialog( "Game already exists with this code" );
            }
          },
          child: Text( "Create game" )
        ),
        TextButton(
          onPressed: () async {
            if( codeController.text.isEmpty ) {
              invalidInputDialog( "Please enter a code" );
            } else if( nameController.text.isEmpty ) {
              invalidInputDialog( "Please enter a name" );
            } else if( !( await doesGameExist( codeController.text) ) ) {
              invalidInputDialog( "No games exists with this code" );
            }
          },
          child: Text( "Join game" )
        )
      ],
      content: Column(
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
          )
        ]
      ),
      title: Text( "Multiplayer" )
    );
  }
}