import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const spinkit = SpinKitRing(
      color: Colors.lightGreen
    );
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Center(
          child: spinkit
        ),        
      )
    );
  }
}
