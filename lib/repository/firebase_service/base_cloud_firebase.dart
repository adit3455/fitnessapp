import '../export_repo.dart';

abstract class BaseCloudFirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  getData();
}
