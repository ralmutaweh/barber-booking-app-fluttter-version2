import 'package:flutter/material.dart';
import 'package:barber_booking_app/widgets/CustomText.dart';
import 'package:barber_booking_app/Utility/booking_data.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  final BookingData bookingData = BookingData();

  @override
  void initState() {
    super.initState();
    bookingData.initialiseBookingStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: const EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Center(child: CustomTextWidgets.header('Bookings')),
            const SizedBox(height: 20),
            Expanded(child: BookingData().allBookings(context)),
          ],
        ),
      ),
    );
  }
}
