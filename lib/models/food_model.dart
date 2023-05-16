class FoodModel {
  final String name;
  final String image;
  final String description;
  final String type;
  final String calories;
  final String kcal;
  final String fat;
  final String protein;
  final String carbo;
  FoodModel({
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
