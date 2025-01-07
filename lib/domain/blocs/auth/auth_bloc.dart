import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/repositories/firebase_auth_repositories.dart';
import 'package:todo_app/domain/blocs/auth/auth_event.dart';
import 'package:todo_app/domain/blocs/auth/auth_state.dart';
import 'package:todo_app/domain/entities/user_entity.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthRepositories _firebaseAuthRepositories =
      FirebaseAuthRepositories();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignOutEvent>(_onSignOut);
  }

  FutureOr<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      var email = event.email;
      var password = event.password;
      final user = await _firebaseAuthRepositories.signIn(email, password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      AuthError(e.toString());
    }
  }

  FutureOr<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _firebaseAuthRepositories.signUp(
          event.displayName, event.email, event.password);
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  FutureOr<void> _onCheckAuthStatus(
      CheckAuthStatusEvent event, Emitter<AuthState> emit) {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      emit(AuthAuthenticated(UserEntity.fromFirebaseUser(currentUser)));
    } else {
      emit(UnAuthenticated());
    }
  }

  FutureOr<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _firebaseAuth.signOut();
      emit(UnAuthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
