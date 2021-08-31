import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
//https://book-perception.firebaseapp.com/__/auth/handler
abstract class AuthBase{
  User get currentUser;     //the base
  Future<User> signInAnonymously();   // anonymous sign in
  Future<User> signInWithEmailAndPassword(String email, String password); //email and pass sign in

  Future<User> createUserWithEmailAndPassword(String email, String password);   //if there is no account
  Future<void> signOut(); //works for all the methods of signing in
  Stream<User> authStateChanges();  // trying out stream
  Future<User> signInWithGoogle();
  Future<User> signInWithFacebook();
}

class Auth implements AuthBase{

  //instance
  final _firebaseAuth = FirebaseAuth.instance;


  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async{
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithCredential(
      EmailAuthProvider.credential(email: email, password: password),
    );
    return userCredential.user;
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  @override
  Future<User> signInWithGoogle() async{
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    if(googleUser!=null){
      final googleAuth = await googleUser.authentication;
      if(googleAuth.idToken!=null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken
            ));
        return userCredential.user;
      }
    }else{
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_USER',
          message: 'Sign In aborted by the user'
      );
    }

  }
  @override
  Future<User> signInWithFacebook() async {
    final fb = FacebookLogin();
    final response = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (response.status) {
      case FacebookLoginStatus.success:
        final accessToken = response.accessToken;
        final userCredential = await _firebaseAuth.signInWithCredential(
          FacebookAuthProvider.credential(accessToken.token),
        );
        return userCredential.user;
      case FacebookLoginStatus.cancel:
        throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by user',
        );
      case FacebookLoginStatus.error:
        throw FirebaseAuthException(
          code: 'ERROR_FACEBOOK_LOGIN_FAILED',
          message: response.error.developerMessage,
        );
      default:
        throw UnimplementedError();
    }
  }

  @override
  Future<void> signOut() async{
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    final facebookLogin = FacebookLogin();
    await facebookLogin.logOut();
    await _firebaseAuth.signOut();
  }

}