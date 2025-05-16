import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/widgets/CustomeSnackBar.dart';
import 'package:flutter/material.dart';

class BookingService {
  DatabaseMethods databaseMethods = DatabaseMethods();

  Future<void> addUserToDatabase(
    BuildContext context,
    String service,
    DateTime selectedDate,
    TimeOfDay selectedTime,
    String name,
    String email,
  ) async {
    Map<String, dynamic> userData = {
      'Service': service,
      'Date': '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
      'Time': selectedTime.format(context).toString(),
      'Username': name,
      'Email': email,
    };
    await databaseMethods
        .addUserBooking(context, userData)
        .then((value) {
          CustomSnackBar.show(context, 'Service Booked Successfully', false);
        })
        .catchError((e) {
          CustomSnackBar.show(
            context,
            'Failed to book service, Try again.',
            true,
          );
        });
  }
}
