import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:on_chat/constants.dart';
import 'package:on_chat/pages/sign_in_screen.dart';
import 'package:on_chat/widgets/CustomButon%20.dart';
import 'package:on_chat/widgets/CustomTextField.dart';

import '../helper/showSnackBar.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({super.key});

  @override
  State<signUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<signUpScreen> {
  String id = 'signUpScreen';

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: ListView(
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 100, left: 100, right: 100),
                child: Center(
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You and Your Firends always Connected',
                    style: TextStyle(color: Color.fromARGB(255, 143, 142, 142)),
                  ),
                ],
              ),
              const SizedBox(
                height: 45,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: CustomTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  lableText: 'Email',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: CustomTextField(
                  obscureText: true,
                  onChanged: (data) {
                    password = data;
                  
                  },
                  lableText: 'Password',
                ),
              ),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70.0),
                child: CustomButon(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});

                      try {
                        await registerUser();
                        Navigator.pushNamed(context, 'chatScreen' , arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          showSnackBar(context, 'Weak password.');
                        } else if (e.code == 'email-already-in-use') {
                          showSnackBar(context, 'Email already in use!');
                        }
                      }

                      isLoading = false;
                      setState(() {});
                    } else {}
                    
                  },
                  text: 'Sign up',
                  color: const Color(0xff4293ec),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Color.fromARGB(255, 143, 142, 142)),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'signInScreen');
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Color(0xff4293ec),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
   void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
