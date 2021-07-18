import 'package:chatapp_montejo/profile.dart';
import 'package:flutter/material.dart';
import 'profile.dart';
import 'chat.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({ Key? key }) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ChatPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green[200],
        onTap: onTabTapped, 
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.chat_bubble_outline, color: Colors.black),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.black),
            label: "Profile"
          )
        ],
        fixedColor: Colors.black,
      ),
    );
  }
  
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
}