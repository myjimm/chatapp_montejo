import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({ Key? key }) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  Widget _buildMessageInput() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding: EdgeInsets.only(left: 10,bottom: 10,top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 15,),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write message...",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(width: 15),
                FloatingActionButton(
                  onPressed: (){

                  },
                  child: Icon(Icons.send, color: Colors.white,size: 18,),
                  backgroundColor: Colors.green[200],
                  elevation: 0,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name", 
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
      body: _buildMessageInput()
    );
  }
}