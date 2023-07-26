import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    this.size,
    this.weight,
    this.color,
  });

  final String title;
  final Color? color;
  final double? size;
  final FontWeight? weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: GoogleFonts.varelaRound(
        color: color,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
