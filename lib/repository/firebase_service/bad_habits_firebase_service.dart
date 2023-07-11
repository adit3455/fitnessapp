import 'package:dartz/dartz.dart';
import 'package:fitness_app/models/bad_habits_model.dart';
import 'package:fitness_app/models/export_model.dart';

import 'base_cloud_firebase.dart';

class BadHabitsFirebaseService extends BaseCloudFirebaseService {
  @override
  Future<Either<BadHabitsModel, FailureModel>> getData() async {
    try {
      final snapshot =
          await db.collection('nutrition').doc('dRnDk4vXBuQueR1ccFDb').get();
      final data = snapshot.data() as Map<String, dynamic>;

      if (data.isNotEmpty) {
        return Left(BadHabitsModel.fromJson(data));
      } else {
        return Right(
            FailureModel(message: "Failed to get data on Right Module"));
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}
