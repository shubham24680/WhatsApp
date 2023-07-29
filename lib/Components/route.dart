import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '/Screens/customer_support.dart';
import '/Screens/phone_verification.dart';
import '/Screens/profile_info.dart';
import '/Screens/Home/contact.dart';
import '/Screens/help.dart';

route(settings) {
  Map<String, Widget> location = {
    'verification': const Verification(),
    'phone_help': const PhoneHelp(),
    'otp_help': const OTPHelp(),
    'profile_info': const ProfileInfo(),
    'contact_support': const ContactSupport(),
    'contact': const Contact(),
  };

  return PageTransition(
    child: location[settings.name]!,
    type: PageTransitionType.bottomToTop,
  );
}
