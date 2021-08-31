import 'package:book_perception/auth.dart';
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
              fontSize: 30,
              fontWeight: FontWeight.w300,
              color: Colors.white ,
          ),
        ),
        backgroundColor: Colors.brown[400],
        actions: <Widget>[
          TextButton(onPressed: _signOut,
              child:Text("Log Out",
                  style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300,
                    color: Colors.white,
              ),
    ),
          )
        ],
      ),
      backgroundColor:Colors.brown[100] ,
    );

  }
}
