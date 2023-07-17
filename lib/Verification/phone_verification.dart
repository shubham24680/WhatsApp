import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';

import 'custom_text_field.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});

  static String verify = "";

  @override
  State<Verification> createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
  late TextEditingController countryNameController;
  late TextEditingController countryCodeController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    countryNameController = TextEditingController(text: "India");
    countryCodeController = TextEditingController(text: "91");
    phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryNameController.dispose();
    countryCodeController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    appbar() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Enter your phone number",
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

    textButton(title) {
      return TextButton(
        onPressed: () => Navigator.pop(context),
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.green[400],
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          "$title",
          style: GoogleFonts.varelaRound(
            color: Colors.teal[700],
          ),
        ),
      );
    }

    dialogBox() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.tealAccent[700],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
            child: const Icon(
              Icons.phone,
              color: Colors.white,
              size: 50,
            ),
          ),
          content: Text(
            "To retrieve you phone number, WhatsApp needs permission to make and manage your calls. "
            "Without this permission, WhatsApp will be unable to retrieve your phone number form the SIM.",
            style: GoogleFonts.varelaRound(fontSize: 14),
          ),
          actions: [
            textButton("Not now"),
            textButton("Continue"),
          ],
        ),
      );
    }

    showCountryCodePicker() {
      showCountryPicker(
        context: context,
        useSafeArea: true,
        showPhoneCode: true,
        countryListTheme: CountryListThemeData(
          bottomSheetHeight: MediaQuery.of(context).size.height,
          borderRadius: BorderRadius.circular(0),
          flagSize: 20,
          textStyle: GoogleFonts.varelaRound(),
          searchTextStyle: GoogleFonts.varelaRound(),
          inputDecoration: InputDecoration(
            hintText: "Search countries",
            hintStyle: GoogleFonts.varelaRound(),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.teal.shade700,
                width: 2,
              ),
            ),
          ),
        ),
        onSelect: (country) {
          countryNameController.text = country.name;
          countryCodeController.text = country.phoneCode;
        },
      );
    }

    alertDialog(title) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(
            "$title",
            style: GoogleFonts.varelaRound(color: Colors.grey[700]),
          ),
          actions: [
            textButton("OK"),
          ],
        ),
      );
    }

    Future sendCode() async {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber:
              '+${countryCodeController.text}${phoneNumberController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            Verification.verify = verificationId;
            Navigator.pushNamed(context, 'otp');
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
      }
    }

    verify() {
      final phone = phoneNumberController.text;
      final name = countryNameController.text;
      final code = countryCodeController.text;

      if (phone.isEmpty) {
        return alertDialog("Please enter your phone number.");
      } else if (phone.length <= 9) {
        return alertDialog(
            "The phone number you entered is too short for the country: $name.\n\nInclude your area code if you haven't.");
      } else if (phone.length > 10) {
        return alertDialog(
            "The phone number you entered is too long for the country: $name.");
      } else {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              "You entered the phone number:\n\n+$code $phone\n\nIs this OK, or would you like to edit the number?",
              style: GoogleFonts.varelaRound(color: Colors.grey[700]),
            ),
            actions: [
              textButton("Edit"),
              TextButton(
                onPressed: () => sendCode(),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.green[400],
                  shadowColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  "OK",
                  style: GoogleFonts.varelaRound(
                    color: Colors.teal[700],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "WhatsApp will need to verify your account.",
              style: GoogleFonts.varelaRound(),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () => dialogBox(),
              child: Text(
                "What's my number?",
                style: GoogleFonts.varelaRound(color: Colors.blue[700]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: CustomTextField(
                onTap: () => showCountryCodePicker(),
                controller: countryNameController,
                readOnly: true,
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.teal[700],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
              child: Row(
                children: [
                  SizedBox(
                    width: 70,
                    child: CustomTextField(
                      onTap: () => showCountryCodePicker(),
                      controller: countryCodeController,
                      readOnly: true,
                      prefixText: "+",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextField(
                      controller: phoneNumberController,
                      autofocus: true,
                      hintText: "phone number",
                      textAlign: TextAlign.left,
                      cursorHeight: 25,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Carrier charges may apply",
              style: GoogleFonts.varelaRound(
                color: Colors.grey[600],
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ElevatedButton(
          onPressed: () => verify(),
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
