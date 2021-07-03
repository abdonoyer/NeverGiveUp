import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:give_up_drugs/modules/intro/intro_screen.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'حياه بلا ادمان',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: splash(),
    );
  }
}

class splash extends StatefulWidget {
  static String id = 'splash';
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 2,
      navigateAfterSeconds: new IntroScreen(),
      title: Text(
        'حياه بلا ادمان',
        style: TextStyle(
          fontSize: 50.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      image: Image(
        image: NetworkImage(
          'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512__340.jpg',
        ),
        fit: BoxFit.cover,
        width: 300,
      ),
      backgroundColor: Colors.red,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 200.0,
      onClick: () => print("give up "),
      loaderColor: Colors.white,
    );
  }
}
