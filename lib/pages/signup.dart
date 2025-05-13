import 'package:barber_booking_app/Utility/CustomerSnackBar.dart';
import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/login.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_prefrerences.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? userName, userEmail, userPassword;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formkey =
      GlobalKey<FormState>(); //Form key to validate the form (Error Handling)

  registration() async {
    if (userPassword != null && userName != null && userEmail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: userEmail!,
              password: userPassword!,
            );
        // Store user data in Firestore
        String id = randomAlphaNumeric(10);

        await SharedPrefrerencesHelper().saveUserName(nameController.text);
        await SharedPrefrerencesHelper().saveUserEmail(emailController.text);
        await SharedPrefrerencesHelper().saveUserId(id);

        Map<String, dynamic> userDataMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "Id": id,
        };
        await DatabaseMethods().addUserDetails(userDataMap, id);

        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar.create(
            text: 'Registration Successful',
            isError: false,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.create(
              text: 'Password provided is weak',
              isError: true,
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            CustomSnackBar.create(
              text: 'Account already exists for that email',
              isError: true,
            ),
          );
        }
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
                'Welcome,\n Create your account!',
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
                      'Name:',
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 25.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'John Doe',
                        prefixIcon: Icon(Icons.mail_outlined),
                      ),
                    ),
                    const CustomSizedBox(height: 20),
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
                      onTap:
                          () => {
                            if (_formkey.currentState!.validate())
                              {
                                setState(() {
                                  // To store the values in the variables
                                  userName = nameController.text;
                                  userEmail = emailController.text;
                                  userPassword = passwordController.text;
                                }),
                              },
                            registration(), // Call the registration function
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
                            'Sign Up',
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
                                builder: (context) => const Login(),
                              ),
                            );
                          },
                          child: const Text(
                            'Already have an account? \nSign In',
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
