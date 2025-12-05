import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isLogin = true;

  void toggleMode() {
    isLogin = !isLogin;
    emit(AuthInfo(isLogin ? "Switched to Login" : "Switched to Sign Up"));
  }

  // ------------------------------ SIGN UP ------------------------------
  Future<void> signUpWithEmail(String email, String password, String name) async {
    try {
      emit(AuthLoading());

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      await user!.sendEmailVerification();

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        "name": name,
        "email": email,
        "photoURL": "",
        "uid": user.uid,
      });

      emit(AuthSuccess(user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Sign Up failed"));
    }
  }

  // ------------------------------ LOGIN ------------------------------
  Future<void> signInWithEmail(String email, String password) async {
    try {
      emit(AuthLoading());

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        emit(AuthError("Please verify your email before login."));
        return;
      }

      emit(AuthSuccess(userCredential.user!.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Login failed"));
    }
  }

  // ------------------------------ GOOGLE SIGN IN ------------------------------
  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());

      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        clientId:
            '330809796631-eskr7q0vqa0jrs0ku918esiuvp8af4lb.apps.googleusercontent.com',
      ).signIn();

      if (googleUser == null) {
        emit(AuthError("Google Sign-In cancelled"));
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        "name": user.displayName,
        "email": user.email,
        "photoURL": user.photoURL ?? "",
        "uid": user.uid,
      }, SetOptions(merge: true));

      emit(AuthSuccess(user.uid));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? "Google Sign-In failed"));
    }
  }

  // ------------------------------ RESET PASSWORD ------------------------------
  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthInfo("Password reset email sent"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
