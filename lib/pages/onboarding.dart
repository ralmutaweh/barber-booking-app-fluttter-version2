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
    return Scaffold(
      backgroundColor: const Color(0xFF2b1615),
      body: Container(
        margin: const EdgeInsets.only(top: 130),
        child: Column(
          children: [
            Image.asset('images/loginPageImg.png'),
            const CustomSizedBox(height: 80),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFdf711a),
                borderRadius: BorderRadius.circular(30),
              ),
              child: CustomTextWidgets.commonStyling('Appoint for a hairtcut'),
            ),
          ],
        ),
      ),
    );
  }
}
