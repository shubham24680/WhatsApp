import 'package:flutter/material.dart';

import 'text_style.dart';
import 'buttons.dart';

customAlertDialog(context, title) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      content: CustomText(title: title, color: Colors.grey[700]),
      actions: [
        CustomTextButton(title: "OK", onPressed: () => Navigator.pop(context)),
      ],
    ),
  );
}

customShowDialog(context, title, content, destination) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      elevation: 0,
      titlePadding: const EdgeInsets.all(0),
      title: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.tealAccent[700],
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(4),
          ),
        ),
        child: title,
      ),
      content: CustomText(
        title: content,
        size: 14,
      ),
      actions: [
        CustomTextButton(
            title: "Not now", onPressed: () => Navigator.pop(context)),
        CustomTextButton(title: "Continue", onPressed: destination),
      ],
    ),
  );
}
