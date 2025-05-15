import 'package:barber_booking_app/widgets/CustomeSnackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addUserDetails(
    BuildContext context,
    Map<String, dynamic> userData,
    String id,
  ) async {
    try {
      return await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .set(userData);
    } catch (e) {
      CustomSnackBar.show(context, 'Failed to add user details', true);
    }
  }

  Future addUserBooking(
    BuildContext context,
    Map<String, dynamic> userData,
  ) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Booking')
          .add(userData);
    } catch (e) {
      CustomSnackBar.show(context, 'Failed to add a user', true);
    }
  }

  removeUserBooking(BuildContext context, String id) async {
    try {
      return await FirebaseFirestore.instance
          .collection('Booking')
          .doc(id)
          .delete();
    } catch (e) {
      CustomSnackBar.show(context, 'Failed to remove user booking', true);
    }
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getBookings() async {
    try {
      return FirebaseFirestore.instance.collection('Booking').snapshots();
    } catch (e) {
      throw Exception('Failed to fetch bookings: $e');
    }
  }
}
