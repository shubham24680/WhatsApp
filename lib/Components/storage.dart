import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:whatsapp/Components/dialog.dart';

class UserDetail {
  UserDetail(
    this.uid,
    this.active,
    this.username,
    this.phoneNumber,
    this.profileImageUrl,
  );

  final String uid;
  final bool active;
  final String username;
  final String phoneNumber;
  final String profileImageUrl;

  Map<String, dynamic> _create() {
    return {
      'uid': uid,
      'active': active,
      'username': username,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
    };
  }
}

imageURL(ref, file) async {
  UploadTask? uploadTask;
  uploadTask = FirebaseStorage.instance.ref(ref).putFile(file);

  TaskSnapshot snapshot = await uploadTask;
  return await snapshot.ref.getDownloadURL();
}

FirebaseAuth auth = FirebaseAuth.instance;
saveUserInfo(context, image, username, mounted) async {
  try {
    customLoadingDialog(context, "Saving user info ...");
    String uid = auth.currentUser!.uid;
    String profileImageUrl =
        image != null ? await imageURL('profileImage/$uid', image) : '';

    UserDetail user = UserDetail(
      uid,
      true,
      username,
      auth.currentUser!.phoneNumber!,
      profileImageUrl,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(user._create());
    if (!mounted) return;
    Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
  } catch (e) {
    print("$e");
  }
}

Future<QuerySnapshot> getData() async {
  return await FirebaseFirestore.instance
      .collection('users')
      .where("uid", isEqualTo: auth.currentUser!.uid)
      .get();
}
