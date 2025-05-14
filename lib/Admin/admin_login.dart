import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_app/Utility/auth_service.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final AuthService authService = AuthService();
  final _formkey = GlobalKey<FormState>(); //Form key to validate the form

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
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
            child: const Text(
              'Admin\n Panel',
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
              key: _formkey, //Form key to validate the form (Error Handling)
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Username:',
                    style: TextStyle(
                      color: Color(0xFFB91635),
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    controller: userNameController,
                    decoration: const InputDecoration(
                      hintText: 'Write your username',
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
                  const CustomSizedBox(height: 30),
                  GestureDetector(
                    onTap:
                        () => {
                          authService.loginAdmin(
                            context,
                            userNameController.text,
                            passwordController.text,
                          ),
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
                          'LOG IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
