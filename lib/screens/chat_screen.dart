import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tango/constants.dart';

import '../providers/cityProvider.dart';

late User loggedInUser;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final textController = TextEditingController();

  late String messagetext;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {

    // FirebaseFirestore.instance.collection('messages').doc('guna')
    //     .get().then(( snapshot){
    //   print(snapshot.data()!['group']);
    //   for(var val in snapshot.data()!['group']) {
    //     print(val);
    //   }
    //
    // });



    return Consumer<CityProvider>(
      builder:(context,cp,child)=> Scaffold(
        appBar: buildAppBar(cp.city,cp.grpName),
        // AppBar(
        //   leading: Container(),
        //   actions: <Widget>[
        //     // IconButton(
        //     //     icon: Icon(Icons.close),
        //     //     onPressed: () async {
        //     //       await _auth.signOut();
        //     //       Navigator.pop(context);
        //     //       //Implement logout functionality
        //     //     }),
        //   ],
        //   title: Text('Group'),
        //   backgroundColor: Colors.lightBlueAccent,
        // ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: TextField(
                          controller: textController,
                          onChanged: (value) {
                            messagetext = value;

                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                    ),
                    Consumer<CityProvider>(
                        builder: ((context, city, child) =>  MaterialButton(
                      onPressed: () async {
                        textController.clear();
                        try {
                          {
                            if (messagetext.isNotEmpty)
                              _firestore.collection('messages').doc(city.city).collection(city.grpName).add({
                                'sender': loggedInUser.email,
                                'text': messagetext
                              });
                          }
                        } catch (e) {
                          print(e);
                        }

                      },
                      child: Text(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final bool isMe;
  final String text;
  const MessageBubble(
      {Key? key, required this.text, required this.sender, required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe?CrossAxisAlignment.end: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: isMe? Colors.white:Colors.blue),
          ),
          Material(
            borderRadius: isMe?BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) , topLeft: Radius.circular(30)): BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30) , topRight: Radius.circular(30)),
            elevation: 5,
            color: isMe
                ? Colors.lightBlue.withOpacity(0.8)
                : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              child: Text(
                text,
                style: TextStyle(fontSize: 20,
                color: isMe? Colors.white: Colors.blue,)
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<CityProvider>(
        builder: ((context, city, child) =>
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('messages').doc(city.city).collection(city.grpName).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          List<MessageBubble> messageWidgets = [];
          for (var message in messages) {
            final messageText = (message.data()! as dynamic)!['text'];
            final messageSender = (message.data()! as dynamic)!['sender'];
            final CurrentUser = FirebaseAuth.instance.currentUser!.email;
            final messageWidget = MessageBubble(
                text: messageText,
                sender: messageSender,
                isMe: messageSender == CurrentUser ? true : false);

            messageWidgets.add(messageWidget);
          }
          return Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: ListView(
              reverse: true,
              children: messageWidgets,
            ),
          ));
        })));
  }
}
