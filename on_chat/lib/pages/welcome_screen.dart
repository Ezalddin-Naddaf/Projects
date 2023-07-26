import 'package:flutter/material.dart';
import 'package:on_chat/constants.dart';
import 'package:on_chat/pages/sign_in_screen.dart';
import 'package:on_chat/pages/sign_up_screen.dart';
import 'package:on_chat/widgets/CustomButon%20.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 120, left: 100, right: 100),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Get Started',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Start with signing up or sign in.',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(
                'assets/images/photo1.png',
              ),
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: (){Navigator.pushNamed(context, 'signUpScreen',);},
                child: CustomButon(
                  text: 'Sign up',
                  color:kPrimaryColor,
                ),
              ),
           const  Divider(indent: 40, endIndent: 40, height: 30,color: Color.fromARGB(255, 105, 105, 105),),
              GestureDetector(
                onTap: (){Navigator.pushNamed(context, 'signInScreen');},
                child: CustomButon(
                  text: 'Sign in',
                  color:kPrimaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
