import 'package:flutter/material.dart';
import 'package:whatsapp/Components/text_style.dart';

class CustomTab extends StatelessWidget {
  const CustomTab({super.key, required this.title, this.icon, this.onPressed});

  final IconData? icon;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey[400],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.teal[600],
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 20),
            CustomText(
              title: title,
              color: Colors.black,
              size: 16,
              weight: FontWeight.w500,
            ),
          ],
        ),
      ),
    );
  }
}
