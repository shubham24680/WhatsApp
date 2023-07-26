import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/custom_text_field.dart';

class OTP extends StatefulWidget {
  const OTP({super.key, required this.phone});

  final String phone;

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  var code = "";

  @override
  Widget build(BuildContext context) {
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

    Future verifyCode() async {
      try {
        // PhoneAuthCredential credential = PhoneAuthProvider.credential(
        //     verificationId: Verification.verify, smsCode: code);
        // await FirebaseAuth.instance.signInWithCredential(credential);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'profile_info');
      } on FirebaseAuthException catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text(
              "The code you entered is incorrect",
              style: GoogleFonts.varelaRound(color: Colors.grey[700]),
            ),
            actions: [
              textButton("OK"),
            ],
          ),
        );
      }
    }

    Future sendCode() async {
      try {
        // await FirebaseAuth.instance.verifyPhoneNumber(
        //   phoneNumber: widget.phone,
        //   verificationCompleted: (PhoneAuthCredential credential) {},
        //   verificationFailed: (FirebaseAuthException e) {},
        //   codeSent: (String verificationId, int? resendToken) {
        //     Verification.verify = verificationId;
        //     showDialog(
        //       context: context,
        //       builder: (context) => AlertDialog(
        //         content: Text(
        //           "Code sent to ${widget.phone}",
        //           style: GoogleFonts.varelaRound(color: Colors.grey[700]),
        //         ),
        //         actions: [
        //           textButton("OK"),
        //         ],
        //       ),
        //     );
        //   },
        //   codeAutoRetrievalTimeout: (verificationId) {},
        // );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.code)));
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
              "Can't send an SMS with your code because you've tried to register ${widget.phone} recently. Request a call or",
              style: GoogleFonts.varelaRound(),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "wait before requesting an SMS. ",
                  style: GoogleFonts.varelaRound(),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'verification'),
                  child: Text(
                    "Wrong number?",
                    style: GoogleFonts.varelaRound(color: Colors.blue[700]),
                  ),
                ),
              ],
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
              onTap: () => Navigator.pushNamedAndRemoveUntil(
                  context, 'profile_info', (route) => false),
              // onTap: () => sendCode(),
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
