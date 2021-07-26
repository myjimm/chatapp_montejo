import 'package:chatapp_montejo/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/appUsers.dart';
import 'controller/chatroomController.dart';
import 'models/chatMessages.dart';
import 'models/chatroom.dart';


showAddToContactAlert(BuildContext context, AppUser addedUser, User currentUser, String chatID){
  String content = "Would you like to add "+addedUser.username!+"?";
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Add contact',
          style: TextStyle(
            fontWeight: FontWeight.w600
          )
        ),
        content: Text(content),
        actions: [
          TextButton(
            child: Text(
              'NO',
              style: TextStyle(
                color: Colors.red
              )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'OKAY',
              style: TextStyle(
                color: Colors.red
              )
            ),
            onPressed: () {
              //some code here to create the chat and navigate
              List<String> users = [addedUser.username!, currentUser.displayName!];
              ChatroomController().createChatroom(chatID, users);
              var messageSent = DateTime.now();
              var messageId = ChatroomController().generateMessageId();
              ChatMessages newMessage = 
                new ChatMessages(
                  messageId: messageId,
                  message: "",
                  sender: currentUser.displayName,
                  sentTime: messageSent,
                );
              //Adds the message to the database
              ChatroomController().addMessage(chatID, newMessage).then((value){
                Chatroom chatroomUpdates = 
                  new Chatroom(
                    lastMessage: "",
                    lastMessageSentTime: messageSent,
                    lastMessageSender: currentUser.displayName
                  );
                //Updates the Chatroom Details
                ChatroomController().updateLastMessageSent(chatID, chatroomUpdates);
              });
              Navigator.of(context).pop();
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>
                  MessagePage(
                    chattedUser: addedUser.username, 
                    currentUser: currentUser, 
                    chatroomId: chatID,
                    hasNoConversation: true,
                    )));
            },
          )
        ]
      );
    }
  );
}