import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '/Screens/phone_verification.dart';
import '/Screens/otp_screen.dart';
import 'dialog.dart';
import 'permission.dart';

Future sendCode(context, phone) async {
  try {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OTP(
            phone: phone,
          ),
        ),
        (route) => false);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Verification.verify = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  } on FirebaseAuthException catch (e) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));
  }
}

Future verifyCode(context, code) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: Verification.verify, smsCode: code);
    await FirebaseAuth.instance.signInWithCredential(credential);
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, 'profile_info', (route) => false);
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
