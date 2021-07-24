// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'authenticate/auth.dart';
import 'landing.dart';


class Wrapper extends StatelessWidget {
  final status;
  Wrapper({ this.status });

  @override
  Widget build(BuildContext context) {
    if(status == true){
      return LandingPage();
    }
    return Auth();
  }
}