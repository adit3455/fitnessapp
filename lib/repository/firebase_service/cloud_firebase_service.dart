import 'package:fitness_app/repository/firebase_service/base_cloud_firebase.dart';

import '../export_repo.dart';

class FirebaseCloudService extends BaseCloudFirebaseService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
}
