
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Components/Styling.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});
  static const String id = 'ChatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

final messageController = TextEditingController();
 late User loggedinuser;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

     getUser();

  }

  void getUser()async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinuser = user;

      }
    }
    catch(e){
      print(e);
    }
  }




  @override
  Widget build(BuildContext context) {
    late String message;
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {


                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Center(child: Text('⚡️Chat')),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('messages').orderBy('createdAt').snapshots(),
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(!snapshot.hasData){
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.lightGreen,

                      )
                      ,
                    );
                  }
                final messages = snapshot.data.docs.reversed;
                List<MessageContainer> messagesWidgets = [];

               if(messages!=null) {
                 for (var message in messages) {
                  final messageText = message.data()['text'];
                  final messageSender = message.data()['sender'];
                  final currentuser = loggedinuser.email;
                  if(currentuser == messageSender){

                  }
                  final messageWidget = MessageContainer(messageSender, messageText,currentuser == messageSender);
                  messagesWidgets.add(messageWidget);
                 }
               }
               return Expanded(
                 child: ListView(
                   reverse: true,
                   padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 20.0),

                     children: messagesWidgets,

                 ),
               );
                }
                ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                 TextButton(
                    onPressed: () {
                      messageController.clear();
                    _firestore.collection('messages').add(({
                      'sender':_auth.currentUser?.email,
                      'text':message, 'createdAt': FieldValue.serverTimestamp()
                    }));
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageContainer extends StatelessWidget {
 MessageContainer(this.sender,this.text,this.isit);

 final String sender;
 final String text;
 final bool isit;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15.0),

    child: Column(

      crossAxisAlignment: isit? CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(sender,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFEFEFEF)
            ),

        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0,horizontal: 0.0),
          child: Material(
            borderRadius:isit? BorderRadius.only(topLeft:Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)) : BorderRadius.only(topRight:Radius.circular(30.0),bottomLeft: Radius.circular(30.0),bottomRight: Radius.circular(30.0)),
            elevation: 5.0,
            color: isit? Colors.lightBlue : Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isit? Color(0xFFEFEFEF): Colors.black
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
