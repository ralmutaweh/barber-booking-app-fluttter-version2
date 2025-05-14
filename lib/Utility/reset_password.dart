import 'package:barber_booking_app/widgets/CustomeSnackBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPassword {
  Future<void> resetPassword(BuildContext context, String email) async {
    // Function to reset password
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      CustomSnackBar.show(
        context,
        'Password reset email sent to $email',
        false,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        CustomSnackBar.show(
          context,
          'No user found for the email provided.',
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
}
