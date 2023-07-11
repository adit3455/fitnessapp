import 'package:dartz/dartz.dart';
import 'package:fitness_app/repository/firebase_service/base_cloud_firebase.dart';

import '../../models/export_model.dart';

class NutritionFirebaseService extends BaseCloudFirebaseService {
  @override
  Future<Either<NutritionModel, FailureModel>> getData() async {
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

  Future<Either<List<FoodModel>, FailureModel>> searchData(
      {required String text}) async {
    try {
      final snapshot =
          await db.collection('nutrition').doc('m8HTSIkTmdCrF2vpkAkj').get();
      final data = snapshot.data() as Map<String, dynamic>;

      List listData = data['food'];
      List<FoodModel> dataInput =
          listData.map((e) => FoodModel.fromJson(e)).toList();

      final searchResult = dataInput
          .where((element) =>
              element.name.toLowerCase().contains(text.toLowerCase()) ||
              element.name.contains(text))
          .toList();
      if (searchResult.isNotEmpty) {
        return Left(searchResult);
      }
      if (searchResult.isEmpty) {
        return Right(FailureModel(message: "Not found any food."));
      }
      if (text.isEmpty) {
        return Right(FailureModel(message: "Your Search Cannot be empty."));
      } else {
        return Right(FailureModel(message: "Failed to get the food you want."));
      }
    } catch (e) {
      return Right(FailureModel(message: e.toString()));
    }
  }
}
