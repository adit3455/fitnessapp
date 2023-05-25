import 'package:fitness_app/blocs/export_blocs.dart';
import 'package:fitness_app/repository/firebase_service/nutrition_firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitness_app/models/export_model.dart';

part 'search_food_state.dart';

class SearchFoodCubit extends Cubit<SearchFoodState> {
  final NutritionFirebaseService _baseCloudFirebaseService;
  SearchFoodCubit(this._baseCloudFirebaseService) : super(FoodUnsearched());

  Future<void> searchFood(String text) async {
    try {
      emit(FoodLoading());
      final listFood = await _baseCloudFirebaseService.searchData(text: text);
      listFood.fold(
          (l) => emit(FoodSearched(l)), (r) => emit(FoodError(r.message)));
    } catch (e) {
      emit(FoodError(e.toString()));
    }
  }
}
