import 'package:flutter/material.dart';

import '/Components/buttons.dart';
import '/Components/text_style.dart';
import '/Theme/custom_theme.dart';
// import 'Theme/custom_theme.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    upper() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
        child: Image.asset(
          "assets/images/doodles.png",
          color: context.theme.doodleColor,
        ),
      );
    }

    lower() {
      return Column(
        children: [
          const CustomText(
            title: "Welcome to WhatsApp",
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(title: "Read our "),
              CustomLink(
                  title: "Privacy Policy",
                  link:
                      "https://www.whatsapp.com/legal/privacy-policy?lg=en&lc=GB&eea=0"),
              CustomText(title: ". Tap \"Agree and continue\" to "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CustomText(title: "accept the "),
              CustomLink(
                  title: "Terms and Services.",
                  link:
                      "https://www.whatsapp.com/legal/terms-of-service?lg=en&lc=GB&eea=0"),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: CustomElevatedButton(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, 'verification', (route) => false),
              width: 300,
              height: 40,
              title: "AGREE AND CONTINUE",
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(child: upper()),
          Expanded(child: lower()),
        ],
      ),
    );
  }
}
