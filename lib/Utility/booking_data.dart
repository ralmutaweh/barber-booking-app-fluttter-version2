import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:barber_booking_app/widgets/CustomText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingData {
  Stream<QuerySnapshot>? bookingStream;

  Future<void> initialiseBookingStream() async {
    bookingStream = await DatabaseMethods().getBookings();
  }

  Widget allBookings(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: bookingStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading bookings.'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No bookings available.'));
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot docShot = snapshot.data!.docs[index];
            return Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextWidgets.commonStyling(
                      'Service: ${docShot['Service']}',
                    ),
                    const CustomSizedBox(height: 10),
                    CustomTextWidgets.commonStyling(
                      'Username: ${docShot['Username']}',
                    ),
                    const CustomSizedBox(height: 10),
                    CustomTextWidgets.commonStyling('Date: ${docShot['Date']}'),
                    const CustomSizedBox(height: 10),
                    CustomTextWidgets.commonStyling('Time: ${docShot['Time']}'),
                    const CustomSizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFdf711a),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          await DatabaseMethods().removeUserBooking(
                            context,
                            docShot.id,
                          );
                          // Optionally, show a Snackbar here to confirm deletion
                        },
                        child: CustomTextWidgets.buttonText('Done'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
