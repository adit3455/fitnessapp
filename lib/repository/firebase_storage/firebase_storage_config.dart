import 'dart:io';

import 'package:fitness_app/repository/firebase_storage/base_firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../pages/person_pages/edit_profile_screen.dart';

class FirebaseStorageConfig extends BaseFirebaseStorageConfig {
  @override
  Future<void> pickImage(BuildContext context) async {
    try {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null) {
        return;
      }

      final pathRef =
          storage.ref().child("profilepic ${auth.currentUser!.displayName}");

      await pathRef.putFile(File(image.path));

      final url = await pathRef.getDownloadURL();

      await auth.currentUser?.updatePhotoURL(url);
    } catch (e) {
      throw Exception(e.toString());
    }

    if (context.mounted) {
      Navigator.pop(context);
      PersistentNavBarNavigator.pushNewScreen(context,
          screen: const EditProfileScreen(), withNavBar: false);
    }
  }
}
