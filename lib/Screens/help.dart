import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/text_style.dart';

class Help extends StatelessWidget {
  const Help({super.key, this.text, this.onTap});

  final String? text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: const CustomText(
          title: "Problem detected",
          color: Colors.white,
          weight: FontWeight.bold,
          size: 20,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Text(
              text!,
              style: GoogleFonts.varelaRound(
                fontSize: 15,
                wordSpacing: 1.5,
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.teal[400],
              child: const Center(
                child: CustomText(
                  title: "This doesn't answer my question",
                  color: Colors.white,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PhoneHelp extends StatelessWidget {
  const PhoneHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Help(
      text: "We didn't detect a valid phone number.\n\n"
          "Please go back to the previous screen and enter your phone number in full international format:\n\n"
          "   1. Choose your country from country list. This\n        will automatically fill the country code.\n\n"
          "   2. Enter your phone number. Omit any\n        leading 0s before the phone number.\n\n"
          "For example, a correct India phone number will appear as +91 987-654-1234 after being entered.\n\n",
      onTap: () {},
    );
  }
}

class OTPHelp extends StatelessWidget {
  const OTPHelp({super.key});

  @override
  Widget build(BuildContext context) {
    return Help(
      text: "You recently requested a verification code."
          " Please wait the specified amount of time before requesting another verification code. There is no way to expedite this.",
      onTap: () {},
    );
  }
}
