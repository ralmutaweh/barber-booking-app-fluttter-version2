import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userData, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userData);
  }

  Future addUserBooking(Map<String, dynamic> userData) async {
    return await FirebaseFirestore.instance.collection("Booking").add(userData);
  }

  RemoveUserBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("Booking")
        .doc(id)
        .delete();
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getBookings() async {
    return await FirebaseFirestore.instance.collection("Booking").snapshots();
  }
}
