import 'package:chatapp_montejo/services/backend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'authenticate/auth.dart';
import 'loading.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  bool isLoading = true;
  User? currentUser;
  final AuthenticationMethods authMethods = new AuthenticationMethods();

  @override
  void initState(){
    _getCurrentUser();
    super.initState();
  }

  _getCurrentUser() async {
    await authMethods.getCurrentUser().then((result){
      currentUser = result;
      setState(() {
        isLoading = false;
      });
    });
 }

  Widget _buildProfileAcc(String emailAddress) {
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
            Text(emailAddress, 
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
            setState(() {
                isLoading = true;
              });
              //some code to sign out 
              final AuthenticationMethods authmethods = new AuthenticationMethods();
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Sign Out?'
                    ),
                    content: Text(
                      'Are you sure you want to sign out?'
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.black
                          )
                        ),
                        onPressed: () {
                          setState(() {
                            // isVerified = false;
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                          // Navigator.of(context)
                          //   .pushReplacement(MaterialPageRoute(builder: (context)=> Wrapper(status: isVerified)));
                        },
                      ),
                      TextButton(
                        child: Text(
                          'YES',
                          style: TextStyle(
                            color: Colors.red
                          )
                        ),
                        onPressed: () async {
                          //code to actually sign out
                          await authmethods.signOut();
                          Navigator.of(context).pop();
                          Navigator.of(context)
                            .pushReplacement(MaterialPageRoute(builder: (context)=> Auth()));
                        },
                      ),
                    ]
                  );
                }
              );
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
      body: isLoading ? Loading() : SafeArea(
        child: Center(
          child: Column(
            children: [
              _buildProfileAcc((currentUser?.email).toString()),
              _buildSignOutBtn()
            ],
          ) 
        )
      )
    );
  }
}