import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        if( snapshot.connectionState == ConnectionState.done ) {
          return MainApp();
        } else if( snapshot.hasError ) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text( "Error initializing Firebase: ${snapshot.error}" )
              )
            )
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center( child: CircularProgressIndicator.adaptive() )
            )
          );
        }
      }
    )
  );
}

class MainApp extends StatefulWidget {
  const MainApp({ super.key });

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData.dark()
    );
  }
}