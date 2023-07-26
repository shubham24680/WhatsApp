import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/Components/custom_text_field.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    appbar() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Profile info",
          style: GoogleFonts.varelaRound(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) => Navigator.pushNamed(context, value),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'phone_help',
                child: Text(
                  "Help",
                  style: GoogleFonts.varelaRound(),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: appbar(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text(
            "Please provide your name and an optional profile photo",
            style: GoogleFonts.varelaRound(color: Colors.grey[600]),
          ),
          const SizedBox(height: 30),
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.grey[200],
            child: const Icon(
              Icons.add_a_photo,
              size: 45,
              color: Colors.blueGrey,
            ),
          ),
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
