import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthSuccess extends AuthState {
  final String uid;
  AuthSuccess(this.uid);

  @override
  List<Object> get props => [uid];
}

class AuthInfo extends AuthState {
  final String info;
  AuthInfo(this.info);

  @override
  List<Object> get props => [info];
}
