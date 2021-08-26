import 'package:book_perception/Screens/HomePage.dart';
import 'package:book_perception/Screens/sign_in_screen.dart';
import 'package:book_perception/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget{

  const LandingPage({Key key, @required this.auth}) : super(key: key);
  final AuthBase auth;

  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User user = snapshot.data;
            if (user == null) {
              return SignInScreen(
                auth: auth,
              );
            }
            return HomePage(
              auth: auth,
            );
          }
          return Scaffold(
            body: CircularProgressIndicator(),
          );
        }
    );
  }
}
