import 'package:book_perception/Elements/sign_in_button.dart';
import 'package:book_perception/Elements/sign_in_manager.dart';
import 'package:book_perception/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'email_sign_in_page.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);
  final SignInManager manager;
  final bool isLoading;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) => Provider<SignInManager>(
          create: (_) => SignInManager(auth: auth, isLoading: isLoading),
          child: Consumer<SignInManager>(
            builder: (_, manager, __) =>
                SignInScreen(manager: manager, isLoading: isLoading.value),
          ),
        ),
      ),
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      await manager.signInAnonymously();
    } catch (e) {
      return Dialog(
        child: Text(e.toString()),
      );
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await manager.signInWithGoogle();
    } catch (e) {
      return Dialog(
        child: Text(e.toString()),
      );
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await manager.signInWithFacebook();
    } catch (e) {
      return Dialog(
        child: Text(e.toString()),
      );
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Book Perception",
            style: GoogleFonts.satisfy(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.brown[500],
        ),
        backgroundColor: Colors.yellow[50],
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
                SignInButton(
                  path: "assets/images/facebook-logo.png",
                  bgColor: Colors.blue[800],
                  fgColor: Colors.white,
                  text: "Sign In With Facebook",
                  onPress: _signInWithFacebook,
                ),
                SignInButton(
                  path: "assets/images/google-logo.png",
                  bgColor: Colors.white,
                  fgColor: Colors.black,
                  text: "Sign In With Google",
                  onPress: _signInWithGoogle,
                ),
                SignInButton(
                  path: "assets/images/mail.png",
                  bgColor: Colors.green[400],
                  fgColor: Colors.black,
                  text: "Sign In With E-Mail",
                  onPress: () => _signInWithEmail(context),
                ),
                SignInButton(
                  path: "assets/images/incognito.png",
                  bgColor: Colors.grey,
                  fgColor: Colors.white,
                  text: "Sign In Anonymously",
                  onPress: _signInAnonymously,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
