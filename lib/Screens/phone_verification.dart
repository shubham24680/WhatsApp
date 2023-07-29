import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:country_picker/country_picker.dart';

import '/Components/dialog.dart';
import '/Components/buttons.dart';
import '/Components/text_style.dart';
import 'otp_screen.dart';

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
        centerTitle: true,
        title: const Text("Enter your phone number"),
        actions: const [
          CustomPopupMenuButton(value: 'phone_help', title: "Help"),
        ],
      );
    }

    dialogBox() {
      return customShowDialog(
        context,
        const Icon(
          Icons.phone,
          color: Colors.white,
          size: 50,
        ),
        "To retrieve you phone number, WhatsApp needs permission to make and manage your calls. "
        "Without this permission, WhatsApp will be unable to retrieve your phone number form the SIM.",
        () => Navigator.pop(context),
      );
    }

    showCountryCodePicker() {
      showCountryPicker(
        context: context,
        useSafeArea: true,
        showPhoneCode: true,
        favorite: ["IN"],
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
                color: Colors.teal.shade600,
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

    Future sendCode() async {
      try {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(
                phone:
                    '+${countryCodeController.text} ${phoneNumberController.text}',
              ),
            ),
            (route) => false);
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber:
              '+${countryCodeController.text}${phoneNumberController.text}',
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            Verification.verify = verificationId;
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
        return customAlertDialog(context, "Please enter your phone number.");
      } else if (phone.length <= 9) {
        return customAlertDialog(context,
            "The phone number you entered is too short for the country: $name.\n\nInclude your area code if you haven't.");
      } else if (phone.length > 10) {
        return customAlertDialog(context,
            "The phone number you entered is too long for the country: $name.");
      } else {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: CustomText(
              title:
                  "You entered the phone number:\n\n+$code $phone\n\nIs this OK, or would you like to edit the number?",
              color: Colors.grey[700],
            ),
            actions: [
              CustomTextButton(
                  title: "Edit", onPressed: () => Navigator.pop(context)),
              CustomTextButton(title: "OK", onPressed: () => sendCode()),
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
            const CustomText(
                title: "WhatsApp will need to verify your account."),
            GestureDetector(
              onTap: () => dialogBox(),
              child: CustomText(
                title: "What's my number?",
                color: Colors.blue[700],
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
                  color: Colors.teal[600],
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
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            CustomText(
              title: "Carrier charges may apply",
              color: Colors.grey[600],
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: CustomElevatedButton(
          onPressed: () => verify(),
          width: 80,
          height: 40,
          title: "Next",
        ),
      ),
    );
  }
}
