part of 'fetch_nutrition_bloc.dart';

abstract class FetchNutritionEvent extends Equatable {
  const FetchNutritionEvent();

  @override
  List<Object> get props => [];
}

class LoadNutrition extends FetchNutritionEvent {}

class UpdateNutrition extends FetchNutritionEvent {
  final NutritionModel nutrition;
  const UpdateNutrition(this.nutrition);

  @override
  List<Object> get props => [nutrition];
}
