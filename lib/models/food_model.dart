import 'package:isar/isar.dart';

part 'food_model.g.dart';

@Collection()
class FoodModel {
  Id id;
  String name;
  String image;
  String description;
  String type;
  String calories;
  String kcal;
  String fat;
  String protein;
  String carbo;
  FoodModel({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.image,
    required this.description,
    required this.type,
    required this.calories,
    required this.kcal,
    required this.fat,
    required this.protein,
    required this.carbo,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
      name: json['name'],
      image: json['image'],
      description: json['description'],
      type: json['type'],
      calories: json['calories'],
      carbo: json['carbo'],
      fat: json['fat'],
      kcal: json['kcal'],
      protein: json['protein']);
}
