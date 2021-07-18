import 'package:flutter/material.dart';
import 'message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({ Key? key }) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  Widget _buildSearch() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(10),
      child: SizedBox( 
        height: 50,
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search,
              color: Colors.green[200],
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