import 'package:fitness_app/models/export_model.dart';

class NutritionModel {
  String? about;
  List<FoodModel>? food;

  NutritionModel({this.about, this.food});

  NutritionModel.fromJson(Map<String, dynamic> json) {
    about = json['about'];
    if (json['food'] != null) {
      food = <FoodModel>[];
      json['food'].forEach((e) {
        food!.add(FoodModel.fromJson(e));
      });
    }
  }
}
