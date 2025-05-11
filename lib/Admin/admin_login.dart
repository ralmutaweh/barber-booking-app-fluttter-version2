import 'package:barber_booking_app/Admin/booking_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formkey = GlobalKey<FormState>(); //Form key to validate the form

  LoginAdmin() {
    FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != userNameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Your username is not correct. Please try again',
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else if (result.data()['password'] != passwordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Your password is not correct. Please try again',
                style: TextStyle(fontSize: 20),
              ),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BookingAdmin()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        child: Stack(
          //Stack widget to overflow
          children: [
            Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
              child: Text(
                'Admin\n Panel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
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
              decoration: BoxDecoration(
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
                    Text(
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
                      decoration: InputDecoration(
                        hintText: 'Write your username',
                        prefixIcon: Icon(Icons.mail_outlined),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
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
                      decoration: InputDecoration(
                        hintText: 'Write a strong password',
                        prefixIcon: Icon(Icons.password),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 30),
                    GestureDetector(
                      onTap: () => {LoginAdmin()},
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
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
      ),
    );
  }
}
