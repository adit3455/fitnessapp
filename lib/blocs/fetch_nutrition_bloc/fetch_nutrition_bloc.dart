import 'dart:async';

import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/repository/firebase_service/nutrition_firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_nutrition_event.dart';
part 'fetch_nutrition_state.dart';

class FetchNutritionBloc
    extends Bloc<FetchNutritionEvent, FetchNutritionState> {
  final NutritionFirebaseService _nutritionFirebaseService;
  StreamSubscription? _nutritionSubscription;

  FetchNutritionBloc(
      {required NutritionFirebaseService nutritionFirebaseService})
      : _nutritionFirebaseService = nutritionFirebaseService,
        super(NutritionLoading()) {
    on<LoadNutrition>((event, emit) {
      try {
        _nutritionSubscription?.cancel();
        _nutritionSubscription = _nutritionFirebaseService
            .getData()
            .asStream()
            .listen((nutrition) => nutrition.fold(
                (l) => add(UpdateNutrition(l)),
                (r) => emit(NutritionError(r.message))));
      } catch (e) {
        emit(NutritionError(e.toString()));
      }
    });
    on<UpdateNutrition>((event, emit) {
      emit(NutritionLoaded(event.nutrition));
    });
  }
}
