import 'package:book_perception/Elements/sign_in_button.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Perception"),
        ),
       body: Container(
         child: Column(
           children: [
             SignInButton("assets/fb.png", Colors.brown, "Helllo"),
           ],
         ),
       ),
      ),
    );
  }
}