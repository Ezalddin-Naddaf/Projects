import 'package:flutter/material.dart';
import 'package:on_chat/models/massage.dart';

import '../constants.dart';

class CustomBubble extends StatelessWidget {
  const CustomBubble({super.key , required this.message});
 final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
      padding:const EdgeInsets.only(left: 16 , top: 16 , bottom: 16 , right: 16),
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32))),
      child:  Text(
        message!.message,
        style:const TextStyle(fontSize: 20, color: Colors.white),
      ),
      ),
    );
  }
}
class SecondCustomBubble extends StatelessWidget {
  const SecondCustomBubble({super.key , required this.message});
 final Message? message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
      padding:const EdgeInsets.only(left: 16 , top: 16 , bottom: 16 , right: 16),
      margin: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: kSecondPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32))),
      child:  Text(
        message!.message,
        style:const TextStyle(fontSize: 20, color: Colors.white),
      ),
      ),
    );
  }
}
