import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:whatsapp/Components/buttons.dart';
import 'package:whatsapp/Components/permission.dart';
import 'package:whatsapp/Components/text_style.dart';

// ignore: must_be_immutable
class PickImage extends StatefulWidget {
  const PickImage({super.key, required this.getImage});

  final ValueChanged<File?> getImage;

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  File? image;
  Future pickImage(source, Permission permission) async {
    try {
      Navigator.pop(context);
      if (await checkPermission(permission)) {
        final image = await ImagePicker().pickImage(source: source);
        if (image == null) return;

        final imagePath = File(image.path);
        setState(() {
          this.image = imagePath;
          widget.getImage(imagePath);
        });
      }
    } on PlatformException catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.grey,
        child: Ink.image(
          image: ((image != null)
              ? FileImage(image!)
              : const AssetImage("assets/images/photo.png")) as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: () => showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              builder: (context) => Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 200,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 5,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          title: "Profile photo",
                          size: 20,
                          weight: FontWeight.bold,
                        ),
                        CustomIconButton(
                          icon: Icons.delete,
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                              image = null;
                            });
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CustomInkWellButton(
                          title: "Camera",
                          icon: Icons.camera_alt,
                          onTap: () =>
                              pickImage(ImageSource.camera, Permission.camera),
                        ),
                        const SizedBox(width: 30),
                        CustomInkWellButton(
                          title: "Gallery",
                          icon: Icons.photo_size_select_actual,
                          onTap: () => pickImage(
                              ImageSource.gallery, Permission.storage),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
