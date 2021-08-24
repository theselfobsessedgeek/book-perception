import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
  final String text;
  final String path;
  final Color color;

  SignInButton(this.path,this.color,this.text);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: (){},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Image(
                image: AssetImage("$path"),
              ),
            ),
            Expanded(
              child: Text("$text",

              ),
            ),
          ],
        ),
    );
  }
}

