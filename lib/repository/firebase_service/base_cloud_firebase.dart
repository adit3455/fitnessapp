import 'package:cloud_firestore/cloud_firestore.dart';

abstract class BaseCloudFirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  getData();
}
