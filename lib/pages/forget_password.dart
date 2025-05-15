import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_app/Utility/reset_password.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  String? email;
  TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  ResetPassword rs = ResetPassword();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.symmetric(vertical: screenHeight * 0.2),
        child: Column(
          children: [
            const CustomSizedBox(height: 60),
            const Text(
              'Password Recovery',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomSizedBox(height: 20),
            const Text(
              'Enter your email:',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomSizedBox(height: 20),
            Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white70, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'John.Doe@mail.com',
                    hintStyle: TextStyle(fontSize: 18, color: Colors.white),
                    prefixIcon: Icon(
                      Icons.mail,
                      color: Colors.white60,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const CustomSizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFdf711a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: GestureDetector(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                    });
                    rs.resetPassword(context, email!);
                  }
                },
                child: const Text(
                  'Send Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
