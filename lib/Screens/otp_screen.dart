import 'package:flutter/material.dart';

import '/Components/auth.dart';
import '/Components/buttons.dart';
import '/Components/text_style.dart';

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

    return Scaffold(
      appBar: appbar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                title:
                    "Can't send an SMS with your code because you've tried to register ${widget.phone} recently. Request a call or wait before requesting an SMS."),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'verification'),
              child: CustomText(
                title: "Wrong number?",
                color: Colors.blue[700],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
              child: CustomTextField(
                onchanged: (p0) {
                  code = p0;
                  if (p0.length == 6) {
                    verifyCode(context, code);
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
              onTap: () => sendCode(context, widget.phone),
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
