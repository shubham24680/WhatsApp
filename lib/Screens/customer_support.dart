import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Components/buttons.dart';
import '/Components/text_style.dart';

class ContactSupport extends StatefulWidget {
  const ContactSupport({super.key});

  @override
  State<ContactSupport> createState() => _ContactSupportState();
}

class _ContactSupportState extends State<ContactSupport> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[600],
        title: const CustomText(
          title: "Contact support",
          color: Colors.white,
          weight: FontWeight.bold,
          size: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              onChanged: (value) {
                setState(() {
                  active = value.isNotEmpty;
                });
              },
              maxLines: 5,
              cursorColor: Colors.teal[600],
              style: GoogleFonts.varelaRound(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                hintText: "Describe your problem",
                hintStyle: GoogleFonts.varelaRound(),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade600),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal.shade600, width: 2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CustomLink(
                  title: "Visit our Help Centre",
                  link:
                      "https://faq.whatsapp.com/?locale=en_US&eea=0&anid=d9894791-3ece-4259-9b32-4a72f48f1dde&refsrc=deprecated&_rdr",
                ),
                CustomElevatedButton(
                  onPressed: active ? () {} : null,
                  width: 80,
                  height: 40,
                  title: "Next",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
