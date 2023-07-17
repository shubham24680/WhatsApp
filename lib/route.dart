import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'Verification/phone_verification.dart';
import 'help.dart';
import 'otp_screen.dart';
import 'profile_info.dart';

route(settings) {
  Map<String, Widget> location = {
    'verification': const Verification(),
    'phone_help': const PhoneHelp(),
    'otp_help': const OTPHelp(),
    'otp': const OTP(),
    'profile_info': const ProfileInfo(),
  };

  return PageTransition(
    child: location[settings.name]!,
    type: PageTransitionType.bottomToTop,
  );
}
