import 'package:barber_booking_app/pages/booking.dart';
import 'package:barber_booking_app/services/shared_prefrerences.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
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
    getOnTheLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: const EdgeInsets.only(
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
                    const Text(
                      'Hello,',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      name!,
                      style: const TextStyle(
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
            const CustomSizedBox(height: 10),
            const Divider(color: Colors.white38),
            const CustomSizedBox(height: 10),
            const Center(
              child: Text(
                'Services',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const CustomSizedBox(height: 20),
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
                                      const Booking(service: 'Hair Trimming'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: const Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/hair_trimming_service.png',
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              const Text(
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
                      const CustomSizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const Booking(service: 'Beard Trimming'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: const Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/beard_trimming_service.png',
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              const Text(
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
                      const CustomSizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const Booking(service: 'Spa & Massage'),
                            ),
                          );
                        },
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            color: const Color(0xFFe29452),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                'images/hair_trimming_service.png',
                                height: 200,
                                width: 300,
                                fit: BoxFit.cover,
                              ),
                              const Text(
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
