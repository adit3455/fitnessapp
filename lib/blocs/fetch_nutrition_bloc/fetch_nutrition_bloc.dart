import 'dart:async';

import 'package:fitness_app/models/export_model.dart';
import 'package:fitness_app/repository/firebase_service/cloud_firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'fetch_nutrition_event.dart';
part 'fetch_nutrition_state.dart';

class FetchNutritionBloc
    extends Bloc<FetchNutritionEvent, FetchNutritionState> {
  final FirebaseCloudService _firebaseCloudService;
  StreamSubscription? _nutritionSubscription;

  FetchNutritionBloc({required FirebaseCloudService firebaseCloudService})
      : _firebaseCloudService = firebaseCloudService,
        super(NutritionLoading()) {
    on<LoadNutrition>((event, emit) {
      try {
        _nutritionSubscription?.cancel();
        _nutritionSubscription = _firebaseCloudService
            .getNutritionData()
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
