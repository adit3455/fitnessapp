import 'package:fitness_app/models/export_model.dart';
import 'package:dartz/dartz.dart';

import 'base_cloud_firebase.dart';

class WorkoutBeforeEighteenService extends BaseCloudFirebaseService {
  @override
  Future<Either<WorkOutBeforeEighteenModel, FailureModel>> getData() async {
    try {
      final snapshot =
          await db.collection('nutrition').doc('IdBiUadctwEEzGOOzWvg').get();
      final data = snapshot.data() as Map<String, dynamic>;

      if (data.isNotEmpty) {
        return Left(WorkOutBeforeEighteenModel.fromJson(data));
      } else {
        return Right(
            FailureModel(message: "Failed to get data on Right Module"));
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}
