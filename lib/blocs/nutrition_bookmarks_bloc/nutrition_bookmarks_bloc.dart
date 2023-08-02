import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/repository/isar_repo/isar_nutrition_.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'nutrition_bookmarks_event.dart';
part 'nutrition_bookmarks_state.dart';

class NutritionBookmarksBloc
    extends Bloc<NutritionBookmarksEvent, NutritionBookmarksState> {
  final IsarNutrition _isarNutrition;
  NutritionBookmarksBloc({required IsarNutrition isarNutrition})
      : _isarNutrition = isarNutrition,
        super(NutritionBookmarksLoading()) {
    on<StartedNutritionEvent>((event, emit) async {
      emit(NutritionBookmarksLoading());
      final data = await _isarNutrition.getAllIsar();
      emit(NutritionBookmarksLoaded(lFoodModel: data));
    });

    on<SaveNutritionEvent>((event, emit) async {
      await _isarNutrition.saveIsar(event.foodModel);
    });
    on<DeleteNutritionEvent>((event, emit) async {
      emit(NutritionBookmarksLoading());
      await _isarNutrition.deleteByIndex(event.foodModel);
      add(StartedNutritionEvent());
    });
  }
}
