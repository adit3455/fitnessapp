part of 'nutrition_bookmarks_bloc.dart';

abstract class NutritionBookmarksState extends Equatable {
  const NutritionBookmarksState();

  @override
  List<Object> get props => [];
}

class NutritionBookmarksLoading extends NutritionBookmarksState {}

class NutritionBookmarksLoaded extends NutritionBookmarksState {
  final List<FoodModel> lFoodModel;
  const NutritionBookmarksLoaded({required this.lFoodModel});

  @override
  List<Object> get props => [lFoodModel];
}
