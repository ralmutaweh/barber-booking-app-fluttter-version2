import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:barber_booking_app/widgets/CustomText.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
            height: screenHeight / 2,
            width: screenWidth,
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
            child: CustomTextWidgets.header('Admin \nLogin'),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: 40,
            ),
            margin: EdgeInsets.only(top: screenHeight / 4.5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidgets.formText('Username:'),
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
                  CustomTextWidgets.formText('Password:'),
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
                    onTap: () {
                      if (_formKey.currentState?.validate() == true) {
                        authService.loginAdmin(
                          context,
                          userNameController.text,
                          passwordController.text,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
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
                      child: Center(child: CustomTextWidgets.formText('Login')),
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
