import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:near_school_demo/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCQDsTOCvyyuFDsTywdaW3rPXvbFTaHA48",
        authDomain: "nearschool-demo.firebaseapp.com",
        projectId: "nearschool-demo",
        storageBucket: "nearschool-demo.appspot.com",
        messagingSenderId: "804615314093",
        appId: "1:804615314093:web:fe3ed68a7ebab8aa54c424",
        databaseURL: "https://nearschool-demo.firebaseio.com",
      ),
    );
  } else {
    await Firebase.initializeApp(
    );
  }
  runApp(DemoApp());
}

class DemoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
