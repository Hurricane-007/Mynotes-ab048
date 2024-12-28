


// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:mynotes/firebase_options.dart';

import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';
import 'package:mynotes/services/auth/authexceptions.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';

class Registerview extends StatefulWidget {
  const Registerview({super.key});

  @override
  State<Registerview> createState() => _RegisterviewState();
}

class _RegisterviewState extends State<Registerview> {

  late final TextEditingController _email;
  late final TextEditingController _password;
  
  @override
  void initState() {
    _email = TextEditingController ();  
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
            children: [
              TextField(
                controller:_email,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration:const InputDecoration(
                  hintText: "Enter Your Email here "
                ),
              ),
              TextField(
                controller: _password,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(
                  hintText: 'Enter Your password here',
                ),
              ),
              TextButton(
                onPressed: () async{
                  final email = _email.text;
                  final password = _password.text;
                  try{
                       await AuthService.firebase().createUser(
                    email: email, 
                    password: password);
                    //send verification email
                    
                    AuthService.firebase().sendEmailVerification();
                    //pushing verify email route
                  Navigator.of(context).pushNamed(verifyEmailRoute);

                }on WeakPasswordException{
                  
                    await showErrorDialog(context, 
                    'weak password',
                    );  
                  }on EmailAlreadyInUseAuthException{
                      await showErrorDialog(context, 
                    'Email already in use',
                    );
                  }on InvalidEmailAuthException{
                    await showErrorDialog(context, 
                    'invalid Email',
                    );
                  } on GenericAuthException{
                      await showErrorDialog(context, 
                    "Failed to register",
                    );
                  } 
                }
                  
                  , 
                child: const Text('Register'),
              ),
              TextButton(onPressed: (){
                Navigator.of(context).pushNamedAndRemoveUntil(loginRoute, (route) => false);
              }, child: const Text('Already registered? Login here!'),
              )
            ],
          ),
    );
  }
}