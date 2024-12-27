
import 'package:flutter/material.dart';
import 'package:mynotes/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context){
  return showGenericDialog(
    context: context, 
    title: 'Log out', 
    content: 'Are you sure You want to logout',
     optionsBuilder: () =>{
      'cancel':false,
      'Log out': true,
     }
     ).then((value) => value ?? false,
     );
}