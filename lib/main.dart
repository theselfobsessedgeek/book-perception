import 'package:book_perception/Screens/landingPage.dart';
import 'package:book_perception/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      image: Image.asset('assets/images/boomks.jpeg'),
      title: Text("Book Perception",
      style: TextStyle(
        fontWeight: FontWeight.w300,
            fontSize: 50,
      ),

      ),
      photoSize: 150.0,
      navigateAfterSeconds: LandingPage(
        auth: Auth(),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      checkerboardOffscreenLayers: false,

      home: Splash()

    );
  }
}

