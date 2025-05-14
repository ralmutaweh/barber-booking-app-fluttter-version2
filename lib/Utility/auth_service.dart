import 'package:barber_booking_app/Admin/booking_admin.dart';
import 'package:barber_booking_app/widgets/CustomeSnackBar.dart';
import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_prefrerences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class AuthService {
  // Admin login method
  Future<void> loginAdmin(
    BuildContext context,
    String username,
    String password,
  ) async {
    final snapshot = await FirebaseFirestore.instance.collection('Admin').get();

    for (var result in snapshot.docs) {
      if (result.data()['id'] != username.trim()) {
        CustomSnackBar.show(
          context,
          'Username not found. Please try again.',
          true,
        );
        return; // Exit after showing the message
      } else if (result.data()['password'] != password) {
        CustomSnackBar.show(
          context,
          'Incorrect password. Please try again.',
          true,
        );
        return; // Exit after showing the message
      } else {
        // Successful login
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BookingAdmin()),
        );
        return; // Exit after navigation
      }
    }
  }

  // User login method
  Future<void> userLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      // Check the password passed is correct
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackBar.show(context, 'No user found for that email.', true);
      } else if (e.code == 'wrong-password') {
        CustomSnackBar.show(
          context,
          'Wrong password provided for that user.',
          true,
        );
      } else {
        CustomSnackBar.show(
          context,
          'An error occurred. Please try again.',
          true,
        );
      }
    }
  }

  // User registration method
  Future<void> registration(
    BuildContext context,
    String username,
    String email,
    String password,
  ) async {
    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      try {
        // ignore: unused_local_variable
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // Store user data in Firestore
        String id = randomAlphaNumeric(10);

        await SharedPrefrerencesHelper().saveUserName(username);
        await SharedPrefrerencesHelper().saveUserEmail(email);
        await SharedPrefrerencesHelper().saveUserId(id);

        Map<String, dynamic> userDataMap = {
          'Name': username,
          'Email': email,
          'Id': id,
        };
        await DatabaseMethods().addUserDetails(userDataMap, id);

        CustomSnackBar.show(context, 'Registration Successful', false);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          CustomSnackBar.show(context, 'Password provided is weak', true);
        } else if (e.code == 'email-already-in-use') {
          CustomSnackBar.show(
            context,
            'Account already exists for that email',
            true,
          );
        }
      }
    }
  }
}
