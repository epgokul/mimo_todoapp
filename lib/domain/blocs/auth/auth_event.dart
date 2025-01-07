import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Sign In Event
class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Sign Up Event
class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String displayName;

  SignUpEvent(this.email, this.password, this.displayName);

  @override
  List<Object?> get props => [email, password, displayName];
}

// Sign Out Event
class SignOutEvent extends AuthEvent {}

// Check Auth Status Event
class CheckAuthStatusEvent extends AuthEvent {}

// Authenticated Event (When the user is authenticated)
class AuthenticatedEvent extends AuthEvent {
  final User user; // Firebase user object

  AuthenticatedEvent(this.user);

  @override
  List<Object?> get props => [user];
}

// UnAuthenticated Event (When the user is unauthenticated)
class UnAuthenticatedEvent extends AuthEvent {}
