import 'package:barber_booking_app/pages/signup.dart';
import 'package:barber_booking_app/widgets/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_app/widgets/CustomSizedBox.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Center(
        // Center the content vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center items in column
          children: [
            Image.asset(
              'images/loginPageImg.png',
              width: screenWidth * 0.8,
              height: screenHeight * 0.4,
              fit: BoxFit.cover,
            ),
            const CustomSizedBox(height: 80),
            GestureDetector(
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Signup()),
                  ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.025,
                  horizontal: screenWidth * 0.05,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFdf711a),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: CustomTextWidgets.commonStyling('Appoint for a haircut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
