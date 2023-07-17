import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp/Theme/custom_theme.dart';
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

    text(title) {
      return Text(
        "$title",
        maxLines: 2,
        style: GoogleFonts.varelaRound(),
      );
    }

    services(link) async {
      var url = Uri.parse(link);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw "Could not launch $url";
      }
    }

    textButton(title, link) {
      return GestureDetector(
        onTap: () => services(link),
        child: Text(
          "$title",
          style: GoogleFonts.varelaRound(
            color: Colors.blue[700],
          ),
        ),
      );
    }

    lower() {
      return Column(
        // mainAxisAlignment: orientation == Orientation.portrait
        //     ? MainAxisAlignment.start
        //     : MainAxisAlignment.center,
        children: [
          Text(
            "Welcome to WhatsApp",
            style: GoogleFonts.varelaRound(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("Read our "),
              textButton("Privacy Policy",
                  "https://www.whatsapp.com/legal/privacy-policy?lg=en&lc=GB&eea=0"),
              text(". Tap \"Agree and continue\" to "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              text("accept the "),
              textButton("Terms and Services.",
                  "https://www.whatsapp.com/legal/terms-of-service?lg=en&lc=GB&eea=0"),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, 'verification'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: Text(
                "AGREE AND CONTINUE",
                style: GoogleFonts.varelaRound(fontSize: 12),
              ),
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
