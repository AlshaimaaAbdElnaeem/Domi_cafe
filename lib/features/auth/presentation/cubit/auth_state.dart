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
}

class AuthSuccess extends AuthState {
  final dynamic data; // role, user info, or message
  AuthSuccess(this.data);
}

class AuthInfo extends AuthState {
  final String info;
  AuthInfo(this.info);
}
