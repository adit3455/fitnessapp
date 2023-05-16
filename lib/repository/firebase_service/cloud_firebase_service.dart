import 'package:dartz/dartz.dart';

import '../../models/export_model.dart';
import '../../models/failure_model.dart';
import '../export_repo.dart';

class FirebaseCloudService extends BaseCloudFirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<Either<NutritionModel, FailureModel>> getNutritionData() async {
    try {
      final snapshot =
          await db.collection('nutrition').doc('m8HTSIkTmdCrF2vpkAkj').get();
      final data = snapshot.data() as Map<String, dynamic>;

      if (data.isNotEmpty) {
        return Left(NutritionModel.fromJson(data));
      } else {
        return Right(
            FailureModel(message: "Failed to get data on Right Module"));
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}
