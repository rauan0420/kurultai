// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cross/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

import 'auth/mybutton.dart';
import 'services/google_auth.dart';
import 'square.dart';

class SignUpPage extends StatefulWidget {
  final Function()? onTap;
  SignUpPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  // ignore: non_constant_identifier_names
  Future<void> Register() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(child: CircularProgressIndicator());
        });
    try {
      if (passwordController.text == confirmController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        WrongConfirm();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        WrongEmail();
      } else if (e.code == 'wrong-password') {
        WrongPassword();
      } else if (e.code == 'invalid-email') {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Invalid Email'),
              content: const Text(
                  'The email you entered is badly formatted. Please enter a valid email.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  void WrongConfirm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Passwords dont match'),
            content:
                const Text('Passwords are not the same. Please try again!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  void WrongEmail() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Wrong Email!'),
            content:
                const Text('User not found for this email Please try again!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  void WrongPassword() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Wrong Password'),
            content: const Text(
                'The written password is not correct. Please try again!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE6EEFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Hello User',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                const Text(
                  "Welcome to Kurultai!",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 320),
                    child: Text(
                      'Email',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C7A9C)),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Color(0xFF5790DF),
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 300),
                    child: Text(
                      'Password',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C7A9C)),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Color(0xFF5790DF),
                      filled: true,
                    ),
                  ),
                ),

                SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(right: 260),
                    child: Text(
                      'Confirm Password',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6C7A9C)),
                    )),

                //password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: confirmController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: Color(0xFF5790DF),
                      filled: true,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 30),

                //sign in button
                MyButton(
                  onTap: Register,
                  text: 'Sign Up',
                ),

                SizedBox(height: 5),

                //signup
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Already have account?",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Text(
                          " Login",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    )),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Or continue with',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Divider(
                      thickness: 1,
                      color: Colors.black,
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Square(
                      imagePath: 'lib/images/google.png',
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Square(
                      imagePath: 'lib/images/facebook.png',
                      onTap: () => AuthService().loginWithFacebook(),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Square(
                      imagePath: 'lib/images/telephone.png',
                      onTap: () => {},
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Square(
                      imagePath: 'lib/images/user.png',
                      onTap: () => AuthService().signInAnonymously(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
