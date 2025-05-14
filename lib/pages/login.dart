import 'package:barber_booking_app/pages/signup.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:barber_booking_app/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_app/Utility/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? userEmail, userPassword;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            child: CustomTextWidgets.header(
              'Welcome back,\n Sign In to Begin!',
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
                  CustomTextWidgets.formText('email'),
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
                  CustomTextWidgets.formText('Password'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomTextWidgets.commonStyling2('Forget Password?'),
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
                        authService.userLogin(
                          context,
                          userEmail!,
                          userPassword!,
                        );
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
                      child: Center(
                        child: CustomTextWidgets.buttonText('Sign In'),
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
                        child: CustomTextWidgets.commonStyling2(
                          'Don\'t have an account? \nSign Up',
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
    );
  }
}
