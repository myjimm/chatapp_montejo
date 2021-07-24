import 'package:chatapp_montejo/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({ Key? key }) : super(key: key);

  @override
  _VerifyPageState createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {

  Timer? timer;
  User? user;
  final _auth = FirebaseAuth.instance;
  bool status = false;

  @override
  void initState(){
    user = _auth.currentUser;
    user?.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 3), (timer) { 
     checkEmailVerified();
    });
    super.initState();
  }

  @override
  void dispose(){
    timer?.cancel();
    super.dispose();
  }


  Widget _buildVerification(){
    return Center(
      child: Container( 
        padding: EdgeInsets.all(10),
        child: Text("Your verification email has been sent."),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildVerification(),
              SpinKitRing(color: Colors.lightGreen)
            ],
          ),
        ),
      ),
    );
  }

  Future <void> checkEmailVerified() async {
    user = _auth.currentUser;
    await user?.reload();
    if(user!.emailVerified){
      setState(() {
        timer?.cancel();
      });
      status = true;
      Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: status)));
    }
  }

}