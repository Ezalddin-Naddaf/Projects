import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:on_chat/firebase_options.dart';
import 'package:on_chat/pages/chat_screen.dart';
import 'package:on_chat/pages/sign_in_screen.dart';
import 'package:on_chat/pages/sign_up_screen.dart';
import 'package:on_chat/pages/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform,);
  runApp(const OnChat());
}

class OnChat extends StatelessWidget {
  const OnChat({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'signInScreen': (context) => signInScreen(),
        'signUpScreen': (context) =>const signUpScreen(),
        'chatScreen':(context) => const chatScreen(),
      },
      home:const WelcomeScreen(),
    );
  }
}
