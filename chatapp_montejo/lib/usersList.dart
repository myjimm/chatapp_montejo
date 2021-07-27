//allows you to see the person you searched for.

import 'package:chatapp_montejo/controller/chatroomController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/appUsers.dart';
import 'package:provider/provider.dart';
import 'addToContact.dart';
import 'noresult.dart';

class UsersList extends StatefulWidget {
  final emailAddress;
  UsersList({this.emailAddress});
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  String chatroomId='';

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final userSnapshot = Provider.of<List<AppUser?>?>(context) ?? []; 
    final userDisplay = userSnapshot.where((element) => element?.emailAddress == widget.emailAddress)
                          .toList(); 
    return userDisplay.length == 0 ? NoResultsPage() : 
    ListView.builder(
      shrinkWrap: true,
      itemCount: userDisplay.length,
      itemBuilder: (context, index){ 
        return GestureDetector(
          onTap: () async {
            if(user?.email == userDisplay[index]?.emailAddress){
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      "Error"
                    ),
                    content: Text(
                      "You are not allowed to add your own self."
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'OKAY',
                          style: TextStyle(
                            color: Colors.red
                          )
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]
                  );
                }
              );
            }else{
              chatroomId = ChatroomController().generateChatroomId((userDisplay[index]?.username).toString(), user!.displayName.toString());
              dynamic doesExist = await ChatroomController().checkIfContactExists(chatroomId);
              if(doesExist == null){
                showAddToContactAlert(
                  context, 
                  userDisplay[index]!, 
                  user, 
                  chatroomId);
              }else{
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Failed"
                      ),
                      content: Text(
                        "You both already have a connection."
                      ),
                      actions: [
                        TextButton(
                          child: Text(
                            'OKAY',
                            style: TextStyle(
                              color: Colors.red
                            )
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ]
                    );
                  }
                );
              }
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.0,
                color: Color(0xfff85b5e6)
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userDisplay[index]!.username.toString(), 
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      userDisplay[index]!.emailAddress.toString(),
                    ),
                  ],
                ),
              ],
            ),
          )
        );
      }
    );
  }
}