import 'package:book_perception/Elements/sign_in_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignInScreen extends StatelessWidget {
  Future<void> _signInAnonymously() async{
    final UserCredentials = await FirebaseAuth.instance.signInAnonymously();
    print("${UserCredentials.user.uid}");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Book Perception",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300
            ),
          ),
          backgroundColor: Colors.brown[400],
        ),
       backgroundColor:Colors.brown[100] ,
       body: Container(
         child: Column(
           children: [
             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Text("Sign In",
               style: TextStyle(
                 fontSize: 50,
               ),
               ),
             ),
             SignInButton(path:"assets/images/facebook-logo.png",
                 bgColor: Colors.blue[800],
                 fgColor: Colors.white,
                 text:"Sign In With Facebook",
                 onPress: (){},
             ),
             SignInButton(path:"assets/images/google-logo.png",
                 bgColor: Colors.white,
                 fgColor: Colors.black,
                 text:"Sign In With Google",
                 onPress: (){},
             ),
             SignInButton(path:"assets/images/mail.png",

               bgColor: Colors.green[400],
               fgColor: Colors.black,
               text:"Sign In With E-Mail",
               onPress: (){},
             ),
             SignInButton(path:"assets/images/incognito.png",
                 bgColor: Colors.grey,
                 fgColor: Colors.white,
                 text:"Sign In Anonymously",
                 onPress: _signInAnonymously,
             ),
           ],
         ),
       ),
      ),
    );
  }
}