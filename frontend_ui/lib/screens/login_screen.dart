import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart';

class LoginScreen extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '244664483194-ctjf5ft0nq9f2fr9o5scdvc7cfnh45da.apps.googleusercontent.com');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> _signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) {
      return null; // The user canceled the sign-in
    }
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          child: Text('Sign in with Google'),
          onPressed: () async {
            User? user = await _signInWithGoogle();
            if (user != null) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
        ),
      ),
    );
  }
}
