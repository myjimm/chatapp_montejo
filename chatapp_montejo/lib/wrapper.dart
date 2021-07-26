import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authenticate/auth.dart';
import 'landing.dart';


class Wrapper extends StatelessWidget {
  final status;
  Wrapper({ this.status });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if(user == null){
      return Auth();
    }else{
      if(status == true){
       return LandingPage();
      }else{
        return Auth();
      }
    }
  }
}