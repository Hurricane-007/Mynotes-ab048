
import 'package:bloc/bloc.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/bloc/Auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent , AuthState> {

  AuthBloc(AuthProvider provider) : super( const AuthStateUnInitialized() ){
    //send Email Verification
    on<AuthEventSendEmailVerification>((event, emit) async{
        await provider.sendEmailVerification();
        emit(state);
    },);
    on<AuthEventRegister>((event, emit) async{
      final email = event.email;
      final password = event.password;
      try{
        await provider.createUser(email: email, password: password);
        await provider.sendEmailVerification();
        emit(const AuthStateNeedsVerification());
      }on Exception catch(e){
        emit(AuthStateRegistering(e));
      }
    },);
    //initialize event
    on<AuthEventInitialize>((event, emit) async{
     await provider.initialize();
     final user = provider.currentUser;
     if(user==null){
      emit(
        const AuthStateLoggedOut(exception: null, isloading: false)
      );
     }
     else if(!user.isEmailVerified){
        emit(const AuthStateNeedsVerification());
     }else{
      emit(AuthStateLoggedIn(user));
     }
    },);
    //login event
    on<AuthEventLogIn>((event,emit)async{
      emit(const AuthStateLoggedOut(exception: null, isloading: true));
      await Future.delayed(const Duration(seconds: 3));
      final email = event.email;
      final password = event.password;
      try{
        final user = await provider.logIn(email: email, password: password);
        if(!user!.isEmailVerified){
          emit(const AuthStateLoggedOut(exception: null, isloading: false));
          emit(AuthStateNeedsVerification());
        }else{
          emit(const AuthStateLoggedOut(exception: null, isloading: false));
          emit(AuthStateLoggedIn(user));
        }
      }on Exception catch(e){
        emit(AuthStateLoggedOut(exception: e, isloading: false));
      }
    });
    //logout event 
    on<AuthEventLogOut>((event,emit)async{
     
      try{
          await provider.logOut();
          emit(const AuthStateLoggedOut(exception: null, isloading: false));
      }on Exception catch(e){
        emit(AuthStateLoggedOut(exception: e, isloading: false));
      }
    });
  }
}