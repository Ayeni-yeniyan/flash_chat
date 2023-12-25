import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(
      {super.key,
      required this.message,
      required this.mail,
      required this.loggedInUserMail});
  final String message;
  final String mail;
  final String loggedInUserMail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: mail == loggedInUserMail
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: mail == loggedInUserMail
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  )
                : const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
            color: mail == loggedInUserMail
                ? Colors.blue
                : const Color.fromARGB(255, 237, 237, 237),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: mail == loggedInUserMail ? Colors.white : Colors.black,
              fontSize: 17,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
          child: Text(
            mail,
            style: const TextStyle(color: Colors.black, fontSize: 10),
          ),
        ),
      ],
    );
  }
}
