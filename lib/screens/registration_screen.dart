import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:modal_progress_hud_alt/modal_progress_hud_alt.dart';

import '../components/custom_text_button.dart';
import '../components/custom_text_field.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'RegistrationScreen';

  const RegistrationScreen({super.key});
  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        progressIndicator: const CircularProgressIndicator(
          color: Colors.blue,
        ),
        inAsyncCall: isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'tag1',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              CustomTextField(
                  hintTxt: 'Enter your Email',
                  onTap: (value) {
                    email = value;
                  }),
              const SizedBox(
                height: 8.0,
              ),
              CustomTextField(
                  obscureText: true,
                  ispasswordKeyBoard: true,
                  hintTxt: 'Enter your password',
                  onTap: (value) {
                    password = value;
                  }),
              const SizedBox(
                height: 24.0,
              ),
              CustomTextButton(
                name: 'Register',
                onTap: () async {
                  if (email.isNotEmpty && password.isNotEmpty) {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await _auth.createUserWithEmailAndPassword(
                          email: email, password: password);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.pushNamed(context, ChatScreen.id);
                    } catch (e) {
                      print(e);
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
