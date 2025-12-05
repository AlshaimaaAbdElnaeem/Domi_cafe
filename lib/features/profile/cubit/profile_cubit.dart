import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> loadProfile() async {
    try {
      emit(ProfileLoading());

      final user = _auth.currentUser;
      if (user == null) return emit(const ProfileError('No authenticated user'));

      final doc = await _firestore.collection('users').doc(user.uid).get();

      if (!doc.exists) {
        final name = user.displayName ?? '';
        final email = user.email ?? '';
        final photoURL = user.photoURL ?? '';

        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': email,
          'photoURL': photoURL,
          'uid': user.uid,
        });

        emit(ProfileLoaded(uid: user.uid, name: name, email: email, photoURL: photoURL));
        return;
      }

      final data = doc.data()!;
      emit(ProfileLoaded(
        uid: user.uid,
        name: data['name'] ?? '',
        email: data['email'] ?? '',
        photoURL: data['photoURL'] ?? '',
      ));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateName(String newName) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    try {
      emit(ProfileUpdating());
      await _firestore.collection('users').doc(current.uid).update({'name': newName});
      emit(current.copyWith(name: newName));
      emit(ProfileUpdated());
      emit(current.copyWith(name: newName));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updatePhoto(File file) async {
    final current = state;
    if (current is! ProfileLoaded) return;

    try {
      emit(ProfileUpdating());
      final ref = _storage.ref().child('profile_images/${current.uid}.jpg');
      await ref.putFile(file);
      final photoURL = await ref.getDownloadURL();

      await _firestore.collection('users').doc(current.uid).update({'photoURL': photoURL});
      emit(current.copyWith(photoURL: photoURL));
      emit(ProfileUpdated());
      emit(current.copyWith(photoURL: photoURL));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
