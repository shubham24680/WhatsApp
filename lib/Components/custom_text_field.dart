import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.readOnly,
    this.textAlign,
    this.keyboardType,
    this.prefixText,
    this.onTap,
    this.suffixIcon,
    this.onchanged,
    this.autofocus,
    this.fontSize,
    this.cursorHeight,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool? readOnly;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final String? prefixText;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Function(String)? onchanged;
  final double? fontSize;
  final bool? autofocus;
  final double? cursorHeight;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      autofocus: autofocus ?? false,
      cursorColor: Colors.teal[700],
      cursorHeight: cursorHeight,
      style: GoogleFonts.varelaRound(fontSize: fontSize),
      onChanged: onchanged,
      decoration: InputDecoration(
        isDense: true,
        prefixText: prefixText,
        suffix: suffixIcon,
        hintText: hintText,
        hintStyle: GoogleFonts.varelaRound(),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade700),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade700, width: 2),
        ),
      ),
    );
  }
}
