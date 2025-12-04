// features/profile/cubit/profile_state.dart
import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String uid;
  final String name;
  final String email;
  final String photoURL;

  const ProfileLoaded({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoURL,
  });

  ProfileLoaded copyWith({
    String? name,
    String? email,
    String? photoURL,
  }) {
    return ProfileLoaded(
      uid: uid,
      name: name ?? this.name,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
    );
  }

  @override
  List<Object?> get props => [uid, name, email, photoURL];
}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
