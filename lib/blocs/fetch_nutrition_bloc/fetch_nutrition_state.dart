part of 'fetch_nutrition_bloc.dart';

abstract class FetchNutritionState extends Equatable {
  const FetchNutritionState();

  @override
  List<Object> get props => [];
}

class NutritionLoading extends FetchNutritionState {}

class NutritionLoaded extends FetchNutritionState {
  final NutritionModel nutritionModel;
  const NutritionLoaded(this.nutritionModel);

  @override
  List<Object> get props => [nutritionModel];
}

class NutritionError extends FetchNutritionState {
  final String message;
  const NutritionError(this.message);
  @override
  List<Object> get props => [message];
}
