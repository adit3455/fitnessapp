part of 'search_food_cubit.dart';

abstract class SearchFoodState extends Equatable {
  const SearchFoodState();

  @override
  List<Object> get props => [];
}

class FoodUnsearched extends SearchFoodState {}

class FoodSearched extends SearchFoodState {
  final List<FoodModel> listFood;

  const FoodSearched(this.listFood);

  @override
  List<Object> get props => [listFood];
}

class FoodLoading extends SearchFoodState {}

class FoodError extends SearchFoodState {
  final String message;
  const FoodError(this.message);

  @override
  List<Object> get props => [];
}
