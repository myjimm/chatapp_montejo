import 'package:flutter/material.dart';
import 'signin.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget _buildProfileAcc() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Container(
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              color: Colors.green[200],
              size: 100,
            ),
            Text("Name", 
              style: TextStyle(
                fontSize: 30, 
                color: Colors.black
              )
            ),
            Text("Email", 
              style: TextStyle(
                fontSize: 20, 
                color: Colors.black.withOpacity(0.6)
              )
            ),
          ],
        )
      )
    );
  }

  Widget _buildSignOutBtn() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Container(
        child: ElevatedButton(
          child: Text("Sign out",
            style: TextStyle(color: Colors.white)
          ),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: 'Chat-App')));
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 100)
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              _buildProfileAcc(),
              _buildSignOutBtn()
            ],
          ) 
        )
      )
    );
  }
}