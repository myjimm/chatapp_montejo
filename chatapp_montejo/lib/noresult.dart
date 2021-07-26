import 'dart:async';

import 'package:flutter/material.dart';

class NoResultsPage extends StatefulWidget {
  const NoResultsPage({ Key? key }) : super(key: key);

  @override
  _NoResultsPageState createState() => _NoResultsPageState();
}

class _NoResultsPageState extends State<NoResultsPage> {
  @override
  void initState() {
    Timer(Duration(seconds: 1), (){
      String content = "User not found.";
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              content,
            ),
            actions: [
              TextButton(
                child: Text(
                  'OKAY',
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "Montserrat"
                  )
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]
          );
        }
      );
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child:Center(
        child: Text(
            "No results found.",
            textAlign: TextAlign.center,
          ),
        ),
    );
  }
}