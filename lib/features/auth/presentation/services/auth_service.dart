import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // تسجيل الدخول بالإيميل والباسورد
  Future<String?> signInWithEmail(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      if (!_auth.currentUser!.emailVerified) {
        await _auth.currentUser!.sendEmailVerification();
        return "Please verify your email before login.";
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // تسجيل حساب جديد
  Future<String?> signUpWithEmail(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _auth.currentUser!.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  // تسجيل الدخول بجوجل
  Future<String?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        await _auth.signInWithPopup(googleProvider);
      } else {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) return "Sign in aborted by user";
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await _auth.signInWithCredential(credential);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
