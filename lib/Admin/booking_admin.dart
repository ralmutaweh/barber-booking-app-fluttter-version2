import 'package:barber_booking_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin> {
  Stream? BookingStream;

  getOnTheLoad() async {
    BookingStream = await DatabaseMethods().getBookings();
    setState(() {});
  }

  initState() {
    super.initState();
    getOnTheLoad();
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: BookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot
                .hasData // Check if the collection has data
            ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount:
                  snapshot.data.docs.length, // Get the length of the collection
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                DocumentSnapshot docShot = snapshot.data.docs[index];
                return Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(10),
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
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Service: ${docShot['Service']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Name: ${docShot['Username']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Date: ${docShot['Date']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Time: ${docShot['Time']}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Color(0xFFdf711a),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: GestureDetector(
                            onTap: () async {
                              DatabaseMethods().RemoveUserBooking(docShot.id);
                            },
                            child: Text(
                              'Done',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Center(
              child: Text(
                'Bookings',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(child: allBookings()),
          ],
        ),
      ),
    );
  }
}
