import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/Components/storage.dart';

import '/Screens/phone_verification.dart';
import '/Screens/otp_screen.dart';
import 'dialog.dart';

Future sendCode(context, phone) async {
  try {
    Navigator.pop(context);
    customLoadingDialog(context, "Sending a verification code to $phone");
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        customAlertDialog(context, e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        Verification.verify = verificationId;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => OTP(
                phone: phone,
              ),
            ),
            (route) => false);
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
    customLoadingDialog(context, "Verifying code ...");
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: Verification.verify, smsCode: code);
    await FirebaseAuth.instance.signInWithCredential(credential);
    // ignore: use_build_context_synchronously
    Navigator.pushNamedAndRemoveUntil(
        context, 'profile_info', (route) => false);
    // ignore: use_build_context_synchronously
  } on FirebaseAuthException catch (e) {
    customAlertDialog(context, "The code you entered is incorrect");
  }
}
