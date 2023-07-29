import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '/Components/permission.dart';
import '/Components/dialog.dart';
import '/Components/buttons.dart';
import '/Components/text_style.dart';
import 'phone_verification.dart';

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
        centerTitle: true,
        title: const Text("Verifying your number"),
        actions: const [
          CustomPopupMenuButton(value: 'otp_help', title: "Help"),
        ],
      );
    }

    Future verifyCode() async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: Verification.verify, smsCode: code);
        await FirebaseAuth.instance.signInWithCredential(credential);
        // Navigator.pushNamedAndRemoveUntil(
        //     context, 'profile_info', (route) => false);
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, 'profile_info');
        // ignore: use_build_context_synchronously
        customShowDialog(
          context,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.contacts,
                color: Colors.white,
                size: 45,
              ),
              SizedBox(width: 15),
              Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 15),
              Icon(
                Icons.folder,
                color: Colors.white,
                size: 50,
              ),
            ],
          ),
          "Contacts and media\n\n"
          "To easily send messages and photos to friends and family, allow WhatsApp to access your contacts, photos and other media. ",
          () => requestPermission(context),
        );
      } on FirebaseAuthException catch (e) {
        customAlertDialog(context, "The code you entered is incorrect");
      }
    }

    Future sendCode() async {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: widget.phone,
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {},
          codeSent: (String verificationId, int? resendToken) {
            Verification.verify = verificationId;
            customAlertDialog(context, "Code sent to ${widget.phone}");
          },
          codeAutoRetrievalTimeout: (verificationId) {},
        );
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
            CustomText(
                title:
                    "Can't send an SMS with your code because you've tried to register ${widget.phone} recently. Request a call or"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomText(title: "wait before requesting an SMS. "),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, 'verification'),
                  child: CustomText(
                    title: "Wrong number?",
                    color: Colors.blue[700],
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
            CustomText(
              title: "Enter 6-digit code",
              color: Colors.grey[600],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () => sendCode(),
              child: CustomText(
                title: "Didn't receive code?",
                color: Colors.teal[700],
              ),
            )
          ],
        ),
      ),
    );
  }
}
