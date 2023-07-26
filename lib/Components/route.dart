import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../Screens/phone_verification.dart';
import '../Screens/profile_info.dart';
import '/Screens/Home/contact.dart';
import 'help.dart';

route(settings) {
  Map<String, Widget> location = {
    'verification': const Verification(),
    'phone_help': const PhoneHelp(),
    'otp_help': const OTPHelp(),
    'profile_info': const ProfileInfo(),
    'contact': const Contact(),
  };

  return PageTransition(
    child: location[settings.name]!,
    type: PageTransitionType.bottomToTop,
  );
}
