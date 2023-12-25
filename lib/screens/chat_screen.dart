import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../components/custom_stream_builder.dart';
import '/constants.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'ChatScreen';

  const ChatScreen({super.key});
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('messages');
  late User loggedInUser;
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late String messageText;
  String messages = '';

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      print(user);
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Hero(
          tag: 'tag1',
          child: SizedBox(
            height: 5.0,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text(
          'Flash Chat',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomStreamBuilder(
                firestore: _firestore,
                loggedInUser: loggedInUser,
                scrollController: _scrollController),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      controller: textEditingController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (messageText.isEmpty) {
                        return;
                      }
                      try {
                        _firestore.doc(DateTime.now().toString()).set({
                          'text': messageText,
                          'sender': loggedInUser.email
                        });
                        textEditingController.clear();
                        messageText = '';
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text(
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
