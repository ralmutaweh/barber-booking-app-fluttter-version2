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
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    List<Map<String, String>> services = [
      {'name': 'Hair Trimming', 'image': 'images/hair_trimming_service.png'},
      {'name': 'Beard Trimming', 'image': 'images/beard_trimming_service.png'},
      {'name': 'Spa & Massage', 'image': 'images/loginPageImg.png'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: EdgeInsets.symmetric(
          vertical: screenHeight * 0.05,
          horizontal: screenWidth * 0.05,
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
                      name ?? 'User', // Default value if name is null
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
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
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return GestureDetector(
                    key: ValueKey(service['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) => Booking(service: service['name']!),
                        ),
                      );
                    },
                    child: Container(
                      height: 230,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFe29452),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            service['image']!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            service['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
