import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import '../models/chatMessages.dart';
import '../models/chatroom.dart';
import '../services/backend.dart';

class ChatroomController {
  CollectionReference chatroom =
      FirebaseFirestore.instance.collection('chatroom');

 
  generateChatroomId(String a, String b){
    if(a.substring(0,1).codeUnitAt(0) > b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }

  Future checkIfContactExists(String chatroomID) async {
    final snapShot = await chatroom.doc(chatroomID).get();
      if(snapShot.exists){
        return true;
      }else{
        return null;
      }
  }
  
  createChatroom(String chatroomId, List<String>users){
    return chatroom.doc(chatroomId).set({
      'userArray':users,
      'lastMessage': "",
      'lastMessageSender': "",
      'lasMessageSentTime': DateTime.now(),
    });
  }

  updateLastMessageSent(String chatroomID, Chatroom chatroomUpdates){
    return chatroom
      .doc(chatroomID)
      .update({
        'lastMessage': chatroomUpdates.lastMessage,
        'lastMessageSentTime': chatroomUpdates.lastMessageSentTime,
        'lastMessageSender': chatroomUpdates.lastMessageSender
      })
        .then((value) => print("Chat Room updated"))
        .catchError((e) => print("Failed to update Chat Room: $e"));  
  }

  generateMessageId(){
    return randomAlphaNumeric(12);
  }

  addMessage(String chatroomID, ChatMessages chatMessages) async{
    return chatroom.doc(chatroomID)           // it goes to your specific chatroom
      .collection("chats")                    // and searched for the "chats" collection, which basically contains all the documented messages
      .doc(chatMessages.messageId).set({      // it creates the document with the specified ID
        'message': chatMessages.message,      // and sets the message details
        'sender': chatMessages.sender,
        'sentTime': chatMessages.sentTime,
        'deleted': false,
    });
  }

  
  Future<Stream<QuerySnapshot>> retrieveChatroomMessages(String chatroomID) async{
    return chatroom.doc(chatroomID)
      .collection("chats")
      .orderBy("sentTime", descending: false)
      .snapshots();
  }

  Future checkChatroomMessages(String chatroomID) async {
    final chatroomState = await chatroom.doc(chatroomID)
      .collection("chats")
      .orderBy("sentTime", descending: false)
      .get();
    return chatroomState.docs.length;
  }

  
  Future<Stream<QuerySnapshot>> retrieveChatrooms() async {
    String thisUser;
    dynamic user = await AuthenticationMethods().getCurrentUser();
    thisUser = user.displayName;
    return chatroom
      .orderBy("lastMessageSentTime", descending: true)
      .where("userArray", arrayContains: thisUser)
      .snapshots();
  }

  Future<bool> checkForChatrooms() async {
    String thisUser;
    dynamic user = await AuthenticationMethods().getCurrentUser();
    thisUser = user.displayName;
    final checker = await chatroom
      .orderBy("lastMessageSentTime", descending: true)
      .where("userArray", arrayContains: thisUser)
      .get();
    if(checker.docs.isEmpty){
      print("No Contacts");
      return true;
    }else{
      print("Already in Contacts");
      return false;
    }
  }
} 