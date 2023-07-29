import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission(context) async {
  Map<Permission, PermissionStatus> statuses = await [
    Permission.contacts,
    Permission.storage,
    //add more permission to request here.
  ].request();

  if (statuses[Permission.contacts]!.isGranted) {
    //check each permission status after.
    print("Location permission is denied.");
  }

  if (statuses[Permission.storage]!.isGranted) {
    //check each permission status after.
    print("Camera permission is denied.");
  }

  Navigator.pop(context);
}

Future<bool> checkStoragePermission() async {
  const permission = Permission.contacts;

  return await permission.status.isGranted;
}
