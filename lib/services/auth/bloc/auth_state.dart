import 'package:flutter/material.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

@immutable
abstract class AuthState {
  final bool isloading;
  final String? loadingText;
  const AuthState ({required this.isloading, this.loadingText = 'Please Wait a Moment'});
}

class AuthStateUnInitialized extends AuthState{
  const AuthStateUnInitialized({required super.isloading});
}

class AuthStateRegistering extends AuthState{
  final Exception? exception;
 const AuthStateRegistering({required super.isloading,required this.exception});
}

class AuthStateLoggedIn extends AuthState{
  final AuthUser user;
  const AuthStateLoggedIn( {required super.isloading,required this.user});
}

 class AuthStateNeedsVerification extends AuthState{
     const AuthStateNeedsVerification({required super.isloading});
 }

class AuthStateLoggedOut extends AuthState with EquatableMixin{
  final Exception? exception;
  const AuthStateLoggedOut({
  required this.exception, 
  required bool isloading,
  String? loadingText
  }) : super(
    isloading: isloading,
    loadingText: loadingText
  );

  @override
  List<Object?> get props => [exception, isloading];
}



