import 'package:equatable/equatable.dart';
import 'package:todo_app/domain/entities/user_entity.dart';

class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthInitial {
  final UserEntity user;
  AuthAuthenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class UnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
