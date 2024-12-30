import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  const AuthState ();
}

class AuthStateUnInitialized extends AuthState{
  const AuthStateUnInitialized();
}

class AuthStateRegistering extends AuthState{
  final Exception? exception;
 const AuthStateRegistering(this.exception);
}

class AuthStateLoggedIn extends AuthState{
  final AuthUser user;
  const AuthStateLoggedIn(this.user);
}

 class AuthStateNeedsVerification extends AuthState{
     const AuthStateNeedsVerification();
 }

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception;
  final bool isloading;
  const AuthStateLoggedOut({
  required this.exception, 
  required this.isloading
  });

  @override
  List<Object?> get props => [exception, isloading];
}



