import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//https://book-perception.firebaseapp.com/__/auth/handler
abstract class AuthBase{
  User get currentUser;     //the base
  Future<User> signInAnonymously();   //anonymous signIn
  Future<void> signOut(); //works for all the methods of signing in
  Stream<User> authStateChanges();  // trying out stream
  Future<User> signInWithGoogle();
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
  Future<void> signOut() async{
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

}