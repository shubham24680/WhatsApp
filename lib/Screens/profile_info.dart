import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/Components/buttons.dart';
import '/Components/text_style.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  Widget build(BuildContext context) {
    appbar() {
      return AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Profile info"),
        actions: const [
          CustomPopupMenuButton(value: 'contact_support', title: "Help"),
        ],
      );
    }

    return Scaffold(
      appBar: appbar(),
      body: Column(
        children: [
          const SizedBox(height: 20),
          CustomText(
            title: "Please provide your name and an optional profile photo",
            color: Colors.grey[600],
          ),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                const SizedBox(
                  width: 330,
                  child: CustomTextField(
                    textAlign: TextAlign.left,
                    hintText: "Type your name here",
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.insert_emoticon,
                    color: Colors.grey,
                    size: 28,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(80, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            "Next",
            style: GoogleFonts.varelaRound(fontSize: 12),
          ),
        ),
      ),
    );
  }
}
