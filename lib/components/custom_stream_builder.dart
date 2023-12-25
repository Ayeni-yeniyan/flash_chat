import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class CustomStreamBuilder extends StatelessWidget {
  const CustomStreamBuilder({
    super.key,
    required CollectionReference<Map<String, dynamic>> firestore,
    required this.loggedInUser,
    required ScrollController scrollController,
  })  : _firestore = firestore,
        _scrollController = scrollController;

  final CollectionReference<Map<String, dynamic>> _firestore;
  final User loggedInUser;
  final ScrollController _scrollController;

  void _scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 1500),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('An error Occured'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox.square(
              dimension: 60,
              child: CircularProgressIndicator(color: Colors.blue),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text(
              'Send a message to the world...',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black38,
              ),
            ),
          );
        }
        List<MessageBubble> messageList = [];
        final messages = snapshot.data.docs;
        for (var message in messages) {
          MessageBubble newMessage = MessageBubble(
            loggedInUserMail: loggedInUser.email!,
            message: message['text'],
            mail: message['sender'],
          );
          messageList.add(newMessage);
        }
        _scrollDown();

        return Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: ListView(
              controller: _scrollController,
              shrinkWrap: true,
              reverse: true,
              padding: const EdgeInsets.all(8),
              children: messageList.reversed.toList()),
        ));
      },
    );
  }
}
