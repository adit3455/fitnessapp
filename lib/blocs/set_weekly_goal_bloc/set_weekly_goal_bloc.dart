import 'package:fitness_app/models/done_exercise_model.dart';
import 'package:fitness_app/models/set_weekly_goal_model.dart';
import 'package:fitness_app/repository/firebase_exercise_module.dart/firebase_exercise_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../config/calendar_config.dart';
import '../../repository/isar_repo/isar_set_weekly.dart';

part 'set_weekly_goal_event.dart';
part 'set_weekly_goal_state.dart';

class SetWeeklyGoalBloc extends Bloc<SetWeeklyGoalEvent, SetWeeklyGoalState> {
  final FirebaseExerciseModule _firebaseExerciseModule;
  final IsarSetWeekly _isarSetWeekly;
  List<DoneExerciseModel> lDoneExercises = [];
  String? selectedDay;

  SetWeeklyGoalBloc(
      {required FirebaseExerciseModule firebaseExerciseModule,
      required IsarSetWeekly isarSetWeekly})
      : _isarSetWeekly = isarSetWeekly,
        _firebaseExerciseModule = firebaseExerciseModule,
        super(SetWeeklyGoalLoading()) {
    on<SetWeeklyGoalStarted>((event, emit) async {
      emit(SetWeeklyGoalLoading());

      final isarData = await _isarSetWeekly.getAllIsar();

      if (isarData.isEmpty) {
        emit(SetWeeklyGoalSetWeekState(selectedDay: selectedDay));
      }
      if (isarData.isNotEmpty) {
        final data = await _firebaseExerciseModule.getDoneExercise();
        data.fold((l) => lDoneExercises = l,
            (r) => emit(SetWeeklyErrorMessage(message: r.message)));
        final calendarConfig = CalendarConfig(l: lDoneExercises);

        final mapDone = calendarConfig.listDoneToMap;

        final eDoneThisWeek =
            calendarConfig.getThisWeekDates(mapDone.keys.toList());

        final totalDaySet = int.parse(isarData[0].daySet.substring(0, 1));

        emit(SetWeeklyCalendar(
            mapDone: mapDone,
            eDoneThisWeek: eDoneThisWeek,
            totalDaySet: totalDaySet));
      }
    });

    on<SetWeeklyGoalSetup>((event, emit) {
      emit(SetWeeklyGoalSetWeekState(selectedDay: event.selectedDay));
    });

    on<SaveWeeklyGoal>((event, emit) async {
      emit(SetWeeklyGoalLoading());
      final data = SetWeeklyGoalModel(daySet: event.daySet);
      await _isarSetWeekly.saveIsar(data);
      add(SetWeeklyGoalStarted());
    });

    on<SetWeeklyNavigate>((event, emit) {
      emit(SetWeeklyGoalSetWeekState(selectedDay: selectedDay));
    });

    on<UpdateSetWeekly>((event, emit) async {
      emit(SetWeeklyGoalLoading());
      final data = await isarSetWeekly.getAllIsar();
      final uData = data.firstWhere((element) => element.id == 1);
      await isarSetWeekly.updateIsar(uData, event.daySet);
      add(SetWeeklyGoalStarted());
    });
  }
}
