import 'dart:io';

import 'package:fitness_app/repository/firebase_storage/base_firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageConfig extends BaseFirebaseStorageConfig {
  @override
  Future<void> pickImage() async {
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
  }
}
