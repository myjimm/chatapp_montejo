import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'controller/chatroomController.dart';
import 'emptyConversation.dart';
import 'models/chatMessages.dart';
import 'models/chatroom.dart';

class MessagePage extends StatefulWidget {
  final String? chattedUser;
  final User? currentUser;
  final chatroomId;
  final hasNoConversation;
  MessagePage({this.chattedUser, this.currentUser, this.chatroomId, this.hasNoConversation});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String message='';
  String messageId = "";
  TextEditingController messageHolder = TextEditingController();
  bool isFirstTime = true;
  Stream? streamMessages;
  ScrollController _controller = ScrollController();
  bool hasNoConversation = true;
  var numberOfMessages;
  // BoxConstraints? constraints; (constraints!.maxHeight/100)

  getAndSetMessages() async {
    /*
      TO DO:
      Through the chatroom controller, use the method that retrieves the chatroom messages
      and pass to it the chatroomId. The method's return value is to be assigned to 
      the variable streamMessages (which is of Stream data type). 
      
      Don't mind the setState(). The method will be called outside that setState()
    */
    streamMessages = await ChatroomController().retrieveChatroomMessages(widget.chatroomId);
    setState(() {});
  }

  checkMessageBox() async {
    /*
      TO DO:
      Through the chatroom controller, use the method that checks the chatroom messages. This method
      returns the number of message documents found in the chatroom in the database. The method's return 
      value is to be assigned to the variable numberOfMessages.

      Don't mind the setState(). The method will be called outside that setState()
     */
    numberOfMessages = await ChatroomController().checkChatroomMessages(widget.chatroomId);
    setState(() {});
  }

  @override
  void initState(){
    getAndSetMessages();
    checkMessageBox();
    setState(() {
      Timer(
        Duration(milliseconds: 300),
        () => _controller
          .jumpTo(_controller.position.maxScrollExtent)
      );
    });
    super.initState();
  }

  // Widget _buildMessageInput() {
  //   return Stack(
  //     children: <Widget>[
  //       Align(
  //         alignment: Alignment.bottomLeft,
  //         child: Container(
  //           padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
  //           height: 60,
  //           width: double.infinity,
  //           color: Colors.white,
  //           child: Row(
  //             children: <Widget>[
  //               SizedBox(width: 15,),
  //               Expanded(
  //                 child: TextField(
  //                   decoration: InputDecoration(
  //                     hintText: "Write message...",
  //                     hintStyle: TextStyle(color: Colors.black54),
  //                     border: InputBorder.none
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(width: 15),
  //               FloatingActionButton(
  //                 onPressed: (){
                    
  //                 },
  //                 child: Icon(Icons.send, color: Colors.white,size: 18,),
  //                 backgroundColor: Colors.green[200],
  //                 elevation: 0,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  /*
    This is the method which builds the message box or the box where you will be typing your message.
   */
  Widget _buildMessageBoxRow(){
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(top: 10.0),
      child: Container(
        height: 70,
        // constraints: BoxConstraints(
        //   minHeight: 10 *  100
        // ),
        color: Colors.green[200],
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
                color: Colors.white,
                child: TextField(
                  onTap: () {
                    //some code here
                    setState(() {
                      Timer(
                        Duration(milliseconds: 300),
                        () => _controller
                          .jumpTo(_controller.position.maxScrollExtent)
                      );
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  controller: messageHolder,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "Write your message here...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  ),
                  maxLength: 240, // This ensures us that ONLY 240 characters are allowed by the message box.
                  maxLines: 3,
                  onChanged: (input){
                    /*
                      The attribute makes sure that if by some bug, the user can write with more that 240 characters,
                      only the 1st character til the 240th character is saved and stored in the database.
                     */
                    if(input.length > 240){
                      message = input.substring(0,240);
                    }else{
                      message = input;
                    }
                  },
                ),
              ),
            ),
            SizedBox(width: 5),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Row(
                  children: [
                    Text("Send", style: TextStyle(color: Colors.black)),
                    SizedBox(width: MediaQuery.of(context).size.width/30),
                    Icon(
                      Icons.send, color: Colors.white, size: 23,
                    ),
                  ],
                ),
              ),
              onTap: () {
                //create chatRoom
                if(message.isNotEmpty){
                  var messageSent = DateTime.now();
                  messageId = ChatroomController().generateMessageId();
                  List<String> users = [widget.chattedUser.toString(), (widget.currentUser?.displayName).toString()];
                  ChatroomController().createChatroom(widget.chatroomId, users);
                  // code to retrieve other information
                  /*
                    TO DO:
                    Create an instance of the ChatMessages model (the one I assigned you)
                    and pass to it the messageId, message, the currentUser's display name, 
                    and messageSent.
                   */
                  ChatMessages newMessage = 
                    new ChatMessages(
                      messageId: messageId,
                      message: message,
                      sender: widget.currentUser?.displayName.toString(),
                      sentTime: messageSent 
                    );

                  /*
                    What this does is adds the message to the database by calling on the addMessage()
                    method in the ChatroomController. Notice the "then" clause that comes after.

                    This means that after the message has been added, we now create a Chatroom model,
                    which we will essentially be passing to our updateLastMessageSent() method in order to
                    update all other details about the chat (like who sent the last message, when the last 
                    message was sent, and what the last send message was)

                    Next, we called on the updateLastMessageSent() through the ChatroomController and we 
                    pass to it the chatroomId and the chatroomUpdates (the object we instantiated of the class
                    Chatroom, which is a model).
                   */
                  ChatroomController().addMessage(widget.chatroomId, newMessage).then((value){
                    Chatroom chatroomUpdates = 
                      new Chatroom(
                        lastMessage: message,
                        lastMessageSentTime: messageSent,
                        lastMessageSender: widget.currentUser?.displayName
                      );
                    //Updates the Chatroom Details
                    ChatroomController().updateLastMessageSent(widget.chatroomId, chatroomUpdates);
                    //Scrolls to the end of the message
                    Timer(
                      Duration(milliseconds: 10),
                      (){ 
                        _controller
                          .jumpTo(_controller.position.maxScrollExtent);
                      }
                    );
                  });
                  //clears the message field
                  setState(() {
                    //Checks number of messages
                    checkMessageBox();

                    //The hasNoConversation variable is then set to false, which means we DO HAVE A CONVERSATION
                    hasNoConversation = false;

                    //Clears the message box
                    messageHolder.clear();

                    /*
                      Sets the isFirstTime to false, which means that it is no longer our first time
                      chatting with the user because we have already sent our message. 
                    */
                    isFirstTime = false;
                  });
                  messageId = "";
                }
              }
            )
          ],
        )
      ),
    );
  }

  /*
    This is the buildMessages() method which builds a stream so that 
    data from our backend can now be used, accessed, and viewed in our 
    frontend. 

    Because we have a listView builder, this basically creates a list.
    Each element of the list contains each of the documents from the
    chats collection (basically iterating through the documents returned
    from the backend).
   */
  Widget _buildMessages(){
    return StreamBuilder(
      stream: streamMessages,
      builder: (context, snapshot){
        if(!snapshot.hasData){
          return EmptyConversation();
        }
        return Container(
          margin: EdgeInsets.only(bottom: 8.0), 
          child: ListView.builder(
            controller: _controller,
            padding: EdgeInsets.only(bottom: 70.0, top: 16.0),
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index){
              DocumentSnapshot messageSnapshot = (snapshot.data as QuerySnapshot).docs[index];
              return Container(
                margin: EdgeInsets.only(bottom: 5.0),
                child: _buildChatMessageTile(messageSnapshot['message'], 
                        widget.currentUser?.displayName == messageSnapshot['sender']),
              );
            }
          )
        );
      }
    );
  }

  /*
    With each iteration in the list, we are going to create a message tile 
    (or message bubble) 
    This is where we can set our color for the bubble, the length, and the shape,
    so that we may know who is sending which messages.
   */
  Widget _buildChatMessageTile(String thisMessage, bool sentByMe){
    return thisMessage == "" ? Container() :
    Row(
      /*
        Notice the mainAxisAlignment. Recall that this property dictates
        whether a widget is to be seen on the left side, right side, or 
        center of the screen. 

        How this can be understood is:
          * If the message is sent by me (if sentByMe == true), then my chat bubble
            should appear on the right side of the screen (like in messenger.)
          * Otherwise, the chat bubble appears on the left side. 
       */
      mainAxisAlignment: 
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: 0.8 * MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              bottomRight: 
                  sentByMe ? Radius.zero : Radius.circular(20.0),
              topRight: Radius.circular(20.0),
              bottomLeft: 
                  sentByMe ? Radius.circular(20.0) : Radius.zero,
            ),
            color: sentByMe ? Colors.grey[300] : Color(0xfff9bcafa) ,
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          padding: EdgeInsets.all(10.0),
          child: Text(
            thisMessage,
          )
        ),
      ]
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    hasNoConversation = widget.hasNoConversation;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(widget.chattedUser.toString(), 
            style: TextStyle(
              color: Colors.white
            )
          ),
          backgroundColor: Colors.green[200],
          leading: IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }
          ),
        ),
        // body: _buildMessageInput()
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                /*
                  TO DO:
                  1. Call the method which creates the stream for our messages.
                  2. Insert a ternary here that checks if the number of messages is null (no data from the backend at all)
                      * If there are no messages, you should build an empty container widget
                      * Otherwise, create another ternary, which checks if the number of messages is greater than 1 
                        (recall that we have sent one message - an empty string "" by default, which is why we always have
                        one message by default. If we have more than one message, then we have chatted with the person at least
                        once already)
                          - If the number of messages is greater than 1, pass an empty container
                          - Otherwise, send the EmptyConversation page. 

                    What we are doing here is basically checking to see if there are errors in the backend (especially
                    if it returns null)
                */
                _buildMessages(),
                numberOfMessages == null ? Container() : numberOfMessages > 1 ? Container() : EmptyConversation(),
                _buildMessageBoxRow(),
              ],
            )
          ),
      ),
    );
  }
}