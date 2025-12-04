import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool isLogin = true;

  void toggleMode() {
    isLogin = !isLogin;
    emit(AuthInfo(isLogin ? "Switched to Login" : "Switched to Sign Up"));
  }

  Future<void> signUpWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError("Email and Password cannot be empty"));
      return;
    }
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess("user"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(AuthError("Email and Password cannot be empty"));
      return;
    }
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(AuthSuccess("user"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthLoading());
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        emit(AuthError("Google Sign-In cancelled"));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(AuthSuccess("user"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      emit(AuthError("Email cannot be empty"));
      return;
    }
    try {
      emit(AuthLoading());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(AuthInfo("Password reset email sent"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
