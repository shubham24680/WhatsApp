import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whatsapp/Verification/phone_verification.dart';

import 'Verification/custom_text_field.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var code = "";
  @override
  Widget build(BuildContext context) {
    Future verifyCode() async {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Verification.verify, smsCode: code);
      await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, 'profile_info');
    }

    appbar() {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Verifying your number",
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
                value: 'otp_help',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Can't send an SMS with your code because you've tried to register +91 1234567890 recently. Request a call or wait before requesting an SMS.",
              style: GoogleFonts.varelaRound(),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'verification'),
              child: Text(
                "Wrong number?",
                style: GoogleFonts.varelaRound(color: Colors.blue[700]),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: CustomTextField(
                onchanged: (p0) {
                  code = p0;
                  if (p0.length == 6) {
                    verifyCode();
                  }
                },
                autofocus: true,
                hintText: "- - -  - - -",
                fontSize: 30,
                cursorHeight: 40,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Enter 6-digit code",
              style: GoogleFonts.varelaRound(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: null,
              child: Text(
                "Didn't receive code?",
                style: GoogleFonts.varelaRound(
                  color: Colors.teal[700],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
