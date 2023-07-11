import 'dart:async';

import 'package:fitness_app/models/export_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/firebase_exercise_module.dart/firebase_exercise_module.dart';

part 'fetch_exercise_event.dart';
part 'fetch_exercise_state.dart';

class FetchExerciseBloc extends Bloc<FetchExerciseEvent, FetchExerciseState> {
  final FirebaseExerciseModule _firebaseExerciseModule;
  StreamSubscription? _streamSubscription;

  FetchExerciseBloc({required FirebaseExerciseModule firebaseExerciseModule})
      : _firebaseExerciseModule = firebaseExerciseModule,
        super(ExerciseLoading()) {
    on<LoadExercise>((event, emit) {
      try {
        _streamSubscription?.cancel();
        _streamSubscription =
            _firebaseExerciseModule.getData().asStream().listen((exercise) {
          exercise.fold((l) => add(UpdateExercise(l)),
              (r) => emit(ExerciseError(r.toString())));
        });
      } catch (e) {
        emit(ExerciseError(e.toString()));
      }
    });

    on<UpdateExercise>((event, emit) {
      emit(ExerciseLoaded(event.listExercise));
    });
  }
}
