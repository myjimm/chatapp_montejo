import 'package:chatapp_montejo/signin.dart';
import 'package:flutter/material.dart';
import '../signin.dart';
import '../signup.dart';

class Auth extends StatefulWidget {
  const Auth({ Key? key }) : super(key: key);

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool showSignIn = true;

  void toggleView() => setState(() {
    showSignIn = !showSignIn;
  });

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return LoginPage(toggleView: toggleView);
    }else{
      return CreateAnAccountPage(toggleView: toggleView);
    }
  }
}
