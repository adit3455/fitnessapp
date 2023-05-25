import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class BaseFirebaseStorageConfig {
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  ImagePicker imagePicker = ImagePicker();

  Future<void> pickImage();
}
