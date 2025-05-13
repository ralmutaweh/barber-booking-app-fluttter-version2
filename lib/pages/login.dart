import 'package:barber_booking_app/Utility/CustomerSnackBar.dart';
import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/signup.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? userEmail, userPassword;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey =
      GlobalKey<FormState>(); //Form key to validate the form (Error Handling)

  userLogin() async {
    try {
      // Check the password passed is correct
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password:
            passwordController
                .text, //Consider using a trim method to remove any leading or trailing spaces
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.create(
            text: 'No user found for that email.',
            isError: true,
          ),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.create(
            text: 'Wrong password provided for that user.',
            isError: true,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.create(
            text: 'An error occurred. Please try again.',
            isError: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          //Stack widget to overflow
          children: [
            Container(
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFB91635),
                    Color(0xFF621d3c),
                    Color(0xFF311937),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Text(
                'Welcome back,\n Sign In to Begin!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 40,
                right: 30,
                left: 30,
                bottom: 40,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 4.5,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email:',
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'JohnDoe@mymail.com',
                        prefixIcon: Icon(Icons.mail_outlined),
                      ),
                    ),
                    const CustomSizedBox(height: 20),
                    const Text(
                      'Password:',
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Write a strong password',
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    const CustomSizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forget Password',
                          style: TextStyle(
                            color: Color(0xFF621d3c),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const CustomSizedBox(height: 40),
                    GestureDetector(
                      onTap: () {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            userEmail = emailController.text;
                            userPassword = passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB91635),
                              Color(0xFF621d3c),
                              Color(0xFF311937),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const CustomSizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ),
                            );
                          },
                          child: const Text(
                            'Don\'t have an account? \nSign Up',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Color(0xFF621d3c),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
