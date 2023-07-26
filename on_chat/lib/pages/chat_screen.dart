import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:on_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:on_chat/models/massage.dart';
import '../widgets/CustomBubble.dart';

class chatScreen extends StatefulWidget {
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
    

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    var email  = ModalRoute.of(context,)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt,descending: true,).snapshots(),
      builder: (context, snapshot) { 
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(
              Message.fromJson(
                snapshot.data!.docs[i],
              ),
            );
          }
          return Scaffold(
            appBar: (AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: const EdgeInsets.only(left: 220.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('ON CHAT'),
                    Image.asset(
                      'assets/images/photo2.png',
                      height: 70,
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              backgroundColor: kPrimaryColor,
            )),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(

                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                        return messagesList[index].id == email ? CustomBubble(
                        message: messagesList[index],
                      ):SecondCustomBubble(message: messagesList[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {

                      messages.add(
                        {
                          kMessage: data,
                          kCreatedAt: DateTime.now(),
                          kId:email,
                        },
                      );
                      controller.clear();
                      _controller.animateTo(0,
                          duration: const Duration(seconds:1),
                          curve: Curves.easeIn);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Send message... ',
                      suffixIcon: Icon(Icons.send),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Loading...'));
        }
      },
    );
  }
}
