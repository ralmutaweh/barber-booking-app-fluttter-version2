import 'package:barber_booking_app/pages/booking.dart';
import 'package:barber_booking_app/services/shared_prefrerences.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? name;

  getDataFromSharedPreferences() async {
    name = await SharedPrefrerencesHelper().getUserName();
    setState(() {});
  }

  getOnTheLoad() async {
    // When loading the application (init state)
    await getDataFromSharedPreferences();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
          // left: MediaQuery.of(context).size.width * 0.05,
          left: 20,
          right: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      name!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(20),
                //   child: Image.asset("", height: , width: , fit: BoxtFit.cover, )),
              ],
            ),
            SizedBox(height: 10),
            Divider(color: Colors.white38),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Flexible(
              flex: 1,
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Booking(service: 'Hair Trimming'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/hair_trimming_service.png",
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Hair Trimming',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Booking(service: 'Beard Trimming'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/beard_trimming_service.png",
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Beard Trimming',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      Booking(service: 'Spa & Massage'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "images/hair_trimming_service.png",
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              Text(
                                'Spa & Massage',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
