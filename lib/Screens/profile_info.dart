import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/Components/dialog.dart';

import '/Components/storage.dart';
import '/Components/images.dart';
import '/Components/buttons.dart';
import '/Components/text_style.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  late TextEditingController nameController = TextEditingController();
  FocusNode focusNode = FocusNode();
  File? image;
  bool emoji = false;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    focusNode.dispose();
    super.dispose();
  }

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

    submitInfo() {
      if (nameController.text.trim().isEmpty) {
        return customAlertDialog(
            context, "You are required to enter your name before continuing.");
      } else if (nameController.text.trim().length < 3 ||
          nameController.text.trim().length > 25) {
        return customAlertDialog(
            context, "You name must have 3 to 25 character long.");
      }

      saveUserInfo(context, image, nameController.text, mounted);
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
          PickImage(
            getImage: (value) {
              image = value;
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                SizedBox(
                  width: 330,
                  child: CustomTextField(
                    controller: nameController,
                    focusNode: focusNode,
                    textAlign: TextAlign.left,
                    hintText: "Type your name here",
                  ),
                ),
                CustomIconButton(
                  onPressed: () {
                    setState(() {
                      emoji = !emoji;
                    });
                    emoji ? focusNode.requestFocus() : focusNode.unfocus();
                  },
                  icon: emoji ? Icons.keyboard : Icons.insert_emoticon,
                  color: Colors.grey,
                  size: 28,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () => submitInfo(),
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
