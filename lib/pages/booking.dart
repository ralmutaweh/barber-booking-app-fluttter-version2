import 'package:barber_booking_app/Models/user_creds.dart';
import 'package:barber_booking_app/services/shared_prefrerences.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';
import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  final String service;

  const Booking({super.key, required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, email;

  BookingService bookingService = BookingService();

  getDataFromSharedPreferences() async {
    name = await SharedPrefrerencesHelper().getUserName();
    email = await SharedPrefrerencesHelper().getUserEmail();
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

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        _selectedDate.day,
      ),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.06),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              const CustomSizedBox(height: 20),
              const Text(
                'Book your \n appointment today!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const CustomSizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset('images/discount.png', fit: BoxFit.cover),
              ),
              const CustomSizedBox(height: 20),
              Center(
                child: Text(
                  widget.service,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const CustomSizedBox(height: 15),
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFb4817e),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Set a Date:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const CustomSizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: const Icon(
                            Icons.calendar_month,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const CustomSizedBox(width: 10),
                        Text(
                          '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: const Color(0xFFb4817e),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Set a Time:',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const CustomSizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: const Icon(
                            Icons.access_time,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const CustomSizedBox(width: 10),
                        Text(
                          _selectedTime.format(context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const CustomSizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    await bookingService.addUserToDatabase(
                      context,
                      widget.service,
                      _selectedDate,
                      _selectedTime,
                      name!,
                      email!,
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                      horizontal: screenWidth * 0.2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFdf711a),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
