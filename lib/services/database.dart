import 'package:cloud_firestore/cloud_firestore.dart';

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
}
