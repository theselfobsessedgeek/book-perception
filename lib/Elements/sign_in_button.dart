import 'dart:ffi';

import 'package:flutter/material.dart';


class SignInButton extends StatelessWidget {
  SignInButton({this.path, this.bgColor,this.fgColor, this.text,this.opa:1,this.onPress,});
  final String text;
  final String path;
  final Color bgColor;
  final Color fgColor;
  final double opa;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0,10,20,0),
        child: ElevatedButton(onPressed: onPress,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(bgColor),
              foregroundColor: MaterialStateProperty.all<Color>(fgColor),
            ),
            child: Row(

              children: [
                Expanded(
                  child: Opacity(
                    opacity: opa,
                    child: Image(
                      image: AssetImage("$path"),

                    ),
                  ),
                ),
                Expanded(
                  child: Text("$text",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

