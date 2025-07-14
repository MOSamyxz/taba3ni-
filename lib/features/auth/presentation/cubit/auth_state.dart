import 'package:taba3ni/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final UserEntity user;

  const AuthSuccess(this.user);
}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);
}
