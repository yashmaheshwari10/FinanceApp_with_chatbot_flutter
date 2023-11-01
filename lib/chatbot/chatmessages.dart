import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages(
      {super.key,
      required this.text,
      required this.sender,
      required this.isImage});

  final String text;
  final String sender;
  final bool isImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          margin: const EdgeInsets.only(right: 16, top: 5, left: 8, bottom: 5),
          child: CircleAvatar(
            child: Text(sender[0]),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                text,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ))
      ]),
    );
  }
}
