import 'package:chatapp_montejo/noChatRooms.dart';
import 'package:chatapp_montejo/services/backend.dart';
import 'package:chatapp_montejo/usersList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chatroomlist.dart';
import 'controller/chatroomController.dart';
import 'controller/userController.dart';
import 'loading.dart';
// import 'message.dart';
import 'models/appUsers.dart';

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

  getChatroomList() async {
    user = await AuthenticationMethods().getCurrentUser();
    currentUser = user?.displayName;
    streamChatrooms = await ChatroomController().retrieveChatrooms();
    dynamic checker = await ChatroomController().checkForChatrooms();
    hasNoContact = checker;
    setState(() {});
  }

  displayContacts(){
    setState((){
      hasNoContact = false;
    });
  }

  @override
  void initState(){
    isEntered = false;
    getChatroomList();
    super.initState();
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
            isEntered = false;
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
              borderSide: BorderSide(color: Color(0xfff9bcafa))
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

  Widget _buildChatroomsListRow(){
    return StreamBuilder(
      stream: streamChatrooms,
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Loading();
        }
        return ListView.builder(
          itemCount: (snapshot.data as QuerySnapshot).docs.length,
          shrinkWrap: true,
          itemBuilder: (context, index){
            DocumentSnapshot chatroomSnapshot = (snapshot.data as QuerySnapshot).docs[index];
            String chattedUser = chatroomSnapshot.id.replaceAll(currentUser.toString(), "").replaceAll("_", "");
            String emailAddress = user!.email.toString();
            String lastMessage = chatroomSnapshot['lastMessage'];
            var isEmptyMessages = (chatroomSnapshot.data() as dynamic).isEmpty;
            bool hasNoConversation = isEmptyMessages ? true : false;
            hasNoContact = false;
            return ChatroomList(
              emailAddress: emailAddress, 
              lastMessage: lastMessage, 
              chattedUser: chattedUser,
              currentUser: user,
              hasNoConversation: hasNoConversation,
            );
          },
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: StreamProvider<List<AppUser?>?>.value(
          value: UserController().retrieveAllUsers,
          initialData: [],
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  _buildSearch(),
                  MultiProvider(
                    providers: [
                      StreamProvider<User?>(create: (context)=> AuthenticationMethods().user, initialData: null)
                    ],
                    // child: isEntered ? UsersList(emailAddress: searchEmail,):hasNoContact ? Container(child: Text("HELP US LORD")) : Container(child: Text("KAPOY NA"))
                    child: isEntered ? UsersList(emailAddress: searchEmail): hasNoContact? NoChatroomsPage() : _buildChatroomsListRow(),
                  )
                ],
              )
            )
          )
        )
      )
    );
  }
}