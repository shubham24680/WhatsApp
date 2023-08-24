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
    this.focusNode,
  });

  final VoidCallback? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? readOnly;
  final String? prefixText;
  final Widget? suffixIcon;
  final String? hintText;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onchanged;
  final double? fontSize;
  final bool? autofocus;
  final double? cursorHeight;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      focusNode: focusNode,
      readOnly: readOnly ?? false,
      textAlign: textAlign ?? TextAlign.center,
      keyboardType: readOnly == null ? keyboardType : null,
      autofocus: autofocus ?? false,
      cursorColor: Colors.teal[600],
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
          borderSide: BorderSide(color: Colors.teal.shade600),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.teal.shade600, width: 2),
        ),
      ),
    );
  }
}
