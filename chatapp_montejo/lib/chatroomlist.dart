/*
  ALWAYS CHECK YOUR IMPORTS

  What this page is is basically like your usersList.
  The file usersList displays a list of users whose email address is like the one you searched in the searchbar.
  The file chatroomList, however, displays a list of people whom you have added to your contacts. 
 */
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/chatroomController.dart';
import 'controller/userController.dart';
import 'loading.dart';
import 'message.dart';

class ChatroomList extends StatefulWidget {
  final emailAddress, lastMessage, chattedUser, currentUser, hasNoConversation;
  ChatroomList({this.emailAddress, 
                this.lastMessage, 
                this.chattedUser, 
                this.currentUser, 
                this.hasNoConversation});
  @override
  _ChatroomListState createState() => _ChatroomListState();
}

class _ChatroomListState extends State<ChatroomList> {
  bool isLoading = true;
  QuerySnapshot? userInfoSnapshot;
  String? username = "Username", chatroomId;

  @override
  void initState(){
    getUserInformation();
    super.initState();
  }

  getUserInformation() async {
    await UserController().retrieveUserofChatroom(widget.emailAddress)
      .then((result){
        username = result?.docs[0]['username'];
        isLoading = false;
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? Loading() : 
      GestureDetector(
      onTap: () async {
        chatroomId = ChatroomController()
          .generateChatroomId(widget.chattedUser, widget.currentUser.displayName);
          Navigator.of(context)
            .push(MaterialPageRoute(builder: (context)=>
            MessagePage(
              chattedUser: widget.chattedUser, 
              currentUser: widget.currentUser, 
              chatroomId: chatroomId,
              hasNoConversation: widget.hasNoConversation,
            )));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.0,
            color: Color(0xfff85b5e6)
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chattedUser,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Container(
                  width: 0.65 * MediaQuery.of(context).size.width,
                  child: Text(
                    widget.lastMessage == "" ? "Say hello! 👋" : widget.lastMessage,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}