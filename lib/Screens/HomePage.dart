import 'package:book_perception/Screens/search.dart';
import 'package:book_perception/auth.dart';
import 'package:books_finder/books_finder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key,@required this.auth}) : super(key: key);
  final AuthBase auth;
  Future<void> _signOut() async{
    await auth.signOut();
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Book Perception",
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              color: Colors.white ,
          ),
        ),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          TextButton(onPressed: _signOut,
          child: Icon(Icons.logout,color: Colors.white,) ,
          )
        ],
      ),
      backgroundColor:Colors.yellow[50] ,
      body: SearchPage(),

    );

  }

}

