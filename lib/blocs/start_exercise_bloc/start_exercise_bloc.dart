import 'dart:async';

import 'package:fitness_app/config/exercise_config.dart';
import 'package:fitness_app/models/exercises_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/firebase_exercise_module.dart/firebase_exercise_module.dart';

part 'start_exercise_event.dart';
part 'start_exercise_state.dart';

class StartExerciseBloc extends Bloc<StartExerciseEvent, StartExerciseState> {
  final ExerciseConfig _exerciseConfig;
  Timer? _timer;
  final int reduceSecondsBy = 1;
  late Duration durationTimer;
  List<ExerciseModel> accomodateExercise = <ExerciseModel>[];

  StartExerciseBloc({required ExerciseConfig exerciseConfig})
      : _exerciseConfig = exerciseConfig,
        super(UnStartExercise()) {
    on<InitState>((event, emit) async {
      emit(UnStartExercise());

      event.accommodateExercise.isNotEmpty
          ? await FirebaseExerciseModule().handlingUpdateExercise(
              date: event.date,
              duration: event.duration,
              totalCalories: event.totalCalories,
              accomodateExercises: event.accommodateExercise)
          : null;

      await Future.delayed(const Duration(seconds: 1));
      accomodateExercise.clear();
    });

    on<OnStartExercise>((event, emit) {
      emit(NavigateExercise(exercise: event.exercise, index: event.index));
      durationTimer = _exerciseConfig
          .durationConverter(event.exercise[event.index].duration!);
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final seconds = durationTimer.inSeconds - reduceSecondsBy;
        durationTimer = Duration(seconds: seconds);
        add(TimerRunExercise(
            exercise: event.exercise,
            index: event.index,
            duration: durationTimer));
      });
    });

    on<TimerRunExercise>((event, emit) {
      durationTimer = event.duration;

      if (durationTimer.inSeconds == 1) {
        accomodateExercise
            .add((state as StartExerciseInitial).exercises[event.index]);
      }
      if (durationTimer.inSeconds == 0) {
        _timer?.cancel();
        durationTimer = _exerciseConfig
            .durationConverter(event.exercise[event.index + 1].duration!);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);

          add(TimerRunRest(
              duration: durationTimer,
              exercise: event.exercise,
              index: event.index + 1));
        });
      } else {
        emit(StartExerciseInitial(
            exercises: event.exercise,
            index: event.index,
            duration: durationTimer));
      }
    });

    on<TimerRunRest>((event, emit) {
      durationTimer = event.duration;

      if (event.exercise.length - 1 == event.index &&
          durationTimer.inSeconds == 0) {
        _timer?.cancel();
        durationTimer = _exerciseConfig
            .durationConverter(event.exercise[event.index].duration!);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);
          add(ExerciseDone(
              duration: durationTimer,
              exercise: event.exercise,
              index: event.index,
              accommodateExercise: accomodateExercise));
        });
      } else if (durationTimer.inSeconds == 0) {
        _timer?.cancel();
        durationTimer = _exerciseConfig
            .durationConverter(event.exercise[event.index].duration!);
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);
          add(TimerRunExercise(
              duration: durationTimer,
              exercise: event.exercise,
              index: event.index));
        });
      } else {
        emit(RestExerciseState(
            index: event.index,
            duration: durationTimer,
            exercises: event.exercise));
      }
    });

    on<ExerciseDone>((event, emit) {
      durationTimer = event.duration;
      if (durationTimer.inSeconds == 1) {
        accomodateExercise
            .add((state as StartExerciseInitial).exercises[event.index]);
      }
      if (durationTimer.inSeconds == 0) {
        _timer?.cancel();
        emit(DoneExerciseState(accomodateExercise: accomodateExercise));
      } else {
        emit(StartExerciseInitial(
            exercises: event.exercise,
            index: event.index,
            duration: durationTimer));
      }
    });

    on<SkipExercise>((event, emit) {
      durationTimer = _exerciseConfig
          .durationConverter(event.exercises[event.index].duration!);
      if (event.index == event.exercises.length - 1) {
        _timer?.cancel();
        emit(StartExerciseInitial(
            index: event.index,
            exercises: event.exercises,
            duration: durationTimer));
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);
          add(ExerciseDone(
              exercise: event.exercises,
              index: event.index,
              duration: durationTimer,
              accommodateExercise: accomodateExercise));
        });
      } else {
        _timer?.cancel();
        emit(StartExerciseInitial(
            index: event.index,
            exercises: event.exercises,
            duration: durationTimer));
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);
          add(TimerRunExercise(
              exercise: event.exercises,
              index: event.index,
              duration: durationTimer));
        });
      }
    });

    on<NextExercise>((event, emit) {
      if (event.exercises.length - 1 == event.index) {
        durationTimer = _exerciseConfig
            .durationConverter(event.exercises[event.index + 1].duration!);
        emit(DoneExerciseState(accomodateExercise: accomodateExercise));
      } else {
        _timer?.cancel();
        emit(RestExerciseState(
            index: event.index + 1,
            exercises: event.exercises,
            duration: durationTimer));
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          final seconds = durationTimer.inSeconds - reduceSecondsBy;
          durationTimer = Duration(seconds: seconds);
          add(TimerRunRest(
              exercise: event.exercises,
              index: event.index + 1,
              duration: durationTimer));
        });
      }
    });

    on<PreviousExercise>((event, emit) {
      durationTimer = _exerciseConfig
          .durationConverter(event.exercises[event.index - 1].duration!);
      _timer?.cancel();
      emit(StartExerciseInitial(
          exercises: event.exercises,
          duration: durationTimer,
          index: event.index - 1));
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final seconds = durationTimer.inSeconds - reduceSecondsBy;
        durationTimer = Duration(seconds: seconds);
        add(TimerRunRest(
            exercise: event.exercises,
            index: event.index - 1,
            duration: durationTimer));
      });
    });

    on<StopExercise>((event, emit) {
      _timer?.cancel();
      emit(PauseExercise(
          duration: event.duration,
          index: event.index,
          exercises: event.exercises));
    });

    on<IncrementRestDuration>((event, emit) {
      durationTimer = event.duration;
      durationTimer = durationTimer + const Duration(seconds: 20);
      emit(RestExerciseState(
          exercises: event.exercises,
          duration: durationTimer,
          index: event.index));
    });

    on<ResumeExercise>((event, emit) {
      durationTimer = event.duration;
      emit(StartExerciseInitial(
          index: event.index,
          exercises: event.exercises,
          duration: durationTimer));
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final seconds = durationTimer.inSeconds - reduceSecondsBy;
        durationTimer = Duration(seconds: seconds);
        add(TimerRunExercise(
            exercise: event.exercises,
            index: event.index,
            duration: durationTimer));
      });
    });

    on<DoneButtonExercise>((event, emit) {
      _timer?.cancel();
      emit(DoneExerciseState(accomodateExercise: accomodateExercise));
    });
  }
}
