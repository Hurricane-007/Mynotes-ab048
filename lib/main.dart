import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/verifyEmail.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/registerview.dart';
// import 'package:mynotes/views/login_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp( MaterialApp(
      title: 'mynotes app',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 197, 4, 181)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/':(context) => const LoginView(),
        '/registerview/':(context) => const Registerview(),
      
      },
    ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

    @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:  Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform,
         ),
        builder: (context,snapshot){
            switch(snapshot.connectionState){
              case ConnectionState.done:
             final user = FirebaseAuth.instance.currentUser;
             if(user!=null){
              if(user.emailVerified){
                print('Email is verified');
              }else{
                return const VerifyEmailView();
              }
              
             }else{
                    return const LoginView();
             }
             return const Text('Done');
            
             
        default:
         return const CircularProgressIndicator();
            }
        },
      );
  }
}




