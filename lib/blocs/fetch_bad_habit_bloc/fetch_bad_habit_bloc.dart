import 'dart:async';

import 'package:fitness_app/models/bad_habits_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/firebase_service/bad_habits_firebase_service.dart';

part 'fetch_bad_habit_event.dart';
part 'fetch_bad_habit_state.dart';

class FetchBadHabitBloc extends Bloc<FetchBadHabitEvent, FetchBadHabitState> {
  final BadHabitsFirebaseService _badHabitsFirebaseService;
  StreamSubscription? _streamSubscription;
  FetchBadHabitBloc(
      {required BadHabitsFirebaseService badHabitsFirebaseService})
      : _badHabitsFirebaseService = badHabitsFirebaseService,
        super(BadHabitLoading()) {
    on<LoadBadHabit>((event, emit) {
      try {
        _streamSubscription?.cancel();
        _streamSubscription =
            _badHabitsFirebaseService.getData().asStream().listen((badHabits) {
          badHabits.fold((l) => add(UpdateBadHabit(l)),
              (r) => emit(BadHabitError(r.message)));
        });
      } catch (e) {
        emit(BadHabitError(e.toString()));
      }
    });
    on<UpdateBadHabit>((event, emit) {
      emit(BadHabitLoaded(event.badHabitsModel));
    });
  }
}
