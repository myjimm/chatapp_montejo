import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'controller/userController.dart';
import 'message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream? streamChatrooms, streamSearchedUsers;
  String? chatroomId;
  User? user;
  String? currentUser;
  String searchEmail = "";
  dynamic hasNoContact = true;
  bool isEmpty = true;
  bool isEntered = false;
  final searchHolder = TextEditingController();

  onSearchButtonClick(String userEmail) async {
    streamSearchedUsers = await UserController().getUserbyEmail(userEmail);
    setState(() {});
  }

  Widget _buildSearch() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: SizedBox( 
        height: 50,
        child: TextFormField(
          textInputAction: TextInputAction.search,
          keyboardType: TextInputType.emailAddress,
          controller: searchHolder,
          onChanged: (value){
            if(value.isNotEmpty){
              isEmpty = false;
            }else{
              isEmpty = true;
            }
            setState(() {
              searchEmail = value;
            });
          },
          onFieldSubmitted: (input) async {
            //changes the view to retrieve results of the query
            if(input.isNotEmpty){
              setState(() {
                isEntered = true;
              });
              searchEmail = input;
              onSearchButtonClick(searchEmail);
            }
          },
          decoration: InputDecoration(
            suffixIcon: isEmpty ? Icon(Icons.search_outlined) : 
              IconButton(
              onPressed: () {
                setState(() {
                  //Clears the search bar on click
                  isEmpty = true;
                  isEntered = false;
                  searchHolder.clear();
                });
              },
              icon: Icon(Icons.cancel),
            ),
            labelText: 'Search',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightGreen)
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black)
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)
            )
          ),
        )
      ),
    );
  }

  Widget _buildContact() {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Name & Email",
          style: TextStyle(color: Colors.black),
          textAlign: TextAlign.left,
        ),
      ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MessagePage()));
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              _buildSearch(),
              _buildContact()
            ],
          )
        )
      )
    );
  }
}