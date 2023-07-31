import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'text_style.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.onPressed,
    this.icon,
    this.color,
    this.size,
  });

  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      icon: Icon(icon, color: color, size: size),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.onPressed,
    required this.height,
    required this.width,
    required this.title,
  });

  final VoidCallback? onPressed;
  final String title;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, height),
      ),
      child: Text(title),
    );
  }
}

services(link) async {
  var url = Uri.parse(link);
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw "Could not launch $url";
  }
}

class CustomLink extends StatelessWidget {
  const CustomLink({super.key, required this.title, required this.link});

  final String? link;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => services(link),
      child: CustomText(
        title: title,
        color: Colors.blue[700],
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, this.onPressed, required this.title});

  final VoidCallback? onPressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        title: title,
        color: Colors.teal[600],
      ),
    );
  }
}

class CustomPopupMenuButton extends StatelessWidget {
  const CustomPopupMenuButton({super.key, this.value, required this.title});

  final String? value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: (value) => Navigator.pushNamed(context, value),
      splashRadius: 20,
      itemBuilder: (context) => [
        PopupMenuItem(
          value: value,
          child: CustomText(title: title),
        ),
      ],
    );
  }
}

class CustomInkWellButton extends StatelessWidget {
  const CustomInkWellButton(
      {super.key, this.onTap, this.icon, required this.title});

  final VoidCallback? onTap;
  final IconData? icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 1, color: Colors.grey.shade300),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.teal[600],
            ),
          ),
          const SizedBox(height: 10),
          CustomText(title: title),
        ],
      ),
    );
  }
}
