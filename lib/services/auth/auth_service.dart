import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/authuser.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;
  AuthService({required this.provider});
  
  @override
  Future<AuthUser> createUser({required Object email, required String password,}) {
   
  }
  
  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => throw UnimplementedError();
  
  @override
  Future<AuthUser?> logIn({required String email, required String password}) {
    // TODO: implement logIn
    throw UnimplementedError();
  }
  
  @override
  Future<void> logOut() {
    // TODO: implement logOut
    throw UnimplementedError();
  }
  
  @override
  Future<void> sendEmailVerification() {
    // TODO: implement sendEmailVerification
    throw UnimplementedError();
  }

}