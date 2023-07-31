import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermission(context) async {
  await [
    Permission.contacts,
    Permission.storage,
    //add more permission to request here.
  ].request();

  Navigator.pop(context);
}

Future<bool> checkPermission(Permission permission) async {
  final status = await permission.request();

  if (status.isPermanentlyDenied) {
    openAppSettings();
  }

  return status.isGranted;
}
