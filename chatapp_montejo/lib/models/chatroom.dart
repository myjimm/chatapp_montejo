class Chatroom {
  List <String>? users = [];
  String? lastMessage;
  DateTime? lastMessageSentTime;
  String? lastMessageSender;
  String? uid;

  Chatroom({this.users, this.lastMessage, this.lastMessageSentTime, this.lastMessageSender, this.uid});
}