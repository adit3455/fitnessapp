import 'dart:async';

import 'package:fitness_app/repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../config/calendar_config.dart';
import '../../models/done_exercise_model.dart';
part 'reports_exercise_event.dart';
part 'reports_exercise_state.dart';

class ReportsExerciseBloc
    extends Bloc<ReportsExerciseEvent, ReportsExerciseState> {
  final FirebaseExerciseModule _firebaseExerciseModule;
  StreamSubscription? _streamSubscription;
  Map<String, dynamic> dateValue = {};
  final dateTimeNow = DateTime.now();

  ReportsExerciseBloc({required FirebaseExerciseModule firebaseExerciseModule})
      : _firebaseExerciseModule = firebaseExerciseModule,
        super(ReportsExerciseInitial()) {
    on<LoadExerciseReports>((event, emit) async {
      _streamSubscription?.cancel();
      _streamSubscription =
          _firebaseExerciseModule.getDoneExercise().asStream().listen((event) {
        event.fold((l) => add(UpdateExerciseReports(doneExerciseModel: l)),
            (r) => emit(ReportsExerciseError(r.message)));
      });
    });

    on<UpdateExerciseReports>((event, emit) {
      final map = CalendarConfig(l: event.doneExerciseModel).listDoneToMap;

      emit(ReportsLoaded(
          mapDone: map,
          doneExerciseModel: event.doneExerciseModel,
          dateTimeNow: dateTimeNow));
    });
  }
}
