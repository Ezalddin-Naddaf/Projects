
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:on_chat/pages/sign_up_screen.dart';

import '../widgets/CustomButon .dart';
import '../widgets/CustomTextField.dart';

class signInScreen extends StatefulWidget {
  signInScreen({super.key});

  @override
  State<signInScreen> createState() => _signInScreenState();
}

class _signInScreenState extends State<signInScreen> {
  
  String? email;
  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;

  

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
                    'Log In',
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
                    'Remember to get up & stretch once',
                    style: TextStyle(color: Color.fromARGB(255, 143, 142, 142)),
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    ' in a while-your friends and chat',
                    style: TextStyle(color: Color.fromARGB(255, 143, 142, 142)),
                  )
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
                        await logInUser();
                        Navigator.pushNamed(context, 'chatScreen' , arguments: email);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'User not found!');
                        } else if (e.code == 'wrong-password') {
                              showSnackBar(context, 'Wrong password');                        } /**/
                      } catch (e) {
                        print(e);
                        showSnackBar(context, 'There was an error');
                      }

                      isLoading = false;
                      setState(() {});
                    }
                    
                  },
                  text: 'Sign in',
                  color: const Color(0xff4293ec),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Color.fromARGB(255, 143, 142, 142)),
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'signUpScreen');
                    },
                    child: const Text(
                      'Sign up',
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

  Future<void> logInUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
