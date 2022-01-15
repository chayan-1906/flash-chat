import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/widgets/loading.dart';
import 'package:flash_chat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                  SizedBox(height: 48.0),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Email', hintText: 'Enter your email'),
                  ),
                  SizedBox(height: 8.0),
                  TextField(
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.center,
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Password', hintText: 'Enter your password'),
                  ),
                  SizedBox(height: 24.0),
                  RoundedButton(
                    title: 'Register',
                    color: Colors.blueAccent,
                    onPressed: () async {
                      print(email);
                      print(password);
                      try {
                        final newUser =
                            await _firebaseAuth.createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        if (newUser != null) {
                          Navigator.of(context)
                              .pushReplacementNamed(ChatScreen.id);
                        }
                      } catch (error) {
                        print(error);
                      } finally {
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child:
                Visibility(visible: showSpinner, child: LoadingDoubleBounce()),
          ),
        ],
      ),
    );
  }
}
