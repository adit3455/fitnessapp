part of 'nutrition_bookmarks_bloc.dart';

abstract class NutritionBookmarksEvent extends Equatable {
  const NutritionBookmarksEvent();

  @override
  List<Object> get props => [];
}

class StartedNutritionEvent extends NutritionBookmarksEvent {}

class SaveNutritionEvent extends NutritionBookmarksEvent {
  final FoodModel foodModel;
  const SaveNutritionEvent({required this.foodModel});

  @override
  List<Object> get props => [foodModel];
}

class DeleteNutritionEvent extends NutritionBookmarksEvent {
  final FoodModel foodModel;
  const DeleteNutritionEvent({required this.foodModel});

  @override
  List<Object> get props => [foodModel];
}
