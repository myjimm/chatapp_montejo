import 'package:flutter/material.dart';

class NoChatroomsPage extends StatefulWidget {
  @override
  _NoChatroomsPageState createState() => _NoChatroomsPageState();
}

class _NoChatroomsPageState extends State<NoChatroomsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child:Center(
        child: Text(
            "You have no contacts as of the moment.",
            textAlign: TextAlign.center,
          ),
        ),
    );
  }
}