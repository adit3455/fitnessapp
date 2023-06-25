part of 'start_exercise_bloc.dart';

abstract class StartExerciseEvent extends Equatable {
  const StartExerciseEvent();

  @override
  List<Object> get props => [];
}

class OnStartExercise extends StartExerciseEvent {
  final List<ExerciseModel> exercise;
  final int index;

  const OnStartExercise(this.exercise, this.index);
  @override
  List<Object> get props => [exercise, index];
}

class InitState extends StartExerciseEvent {
  final String date;
  final String duration;
  final double totalCalories;
  final List<ExerciseModel> accommodateExercise;

  const InitState(
      {required this.date,
      required this.duration,
      required this.totalCalories,
      required this.accommodateExercise});

  @override
  List<Object> get props => [date, duration, accommodateExercise];
}

class TimerRunExercise extends StartExerciseEvent {
  final List<ExerciseModel> exercise;
  final int index;
  final Duration duration;

  const TimerRunExercise({
    required this.exercise,
    required this.index,
    required this.duration,
  });
  @override
  List<Object> get props => [exercise, index, duration];
}

class ExerciseDone extends StartExerciseEvent {
  final Duration duration;
  final List<ExerciseModel> exercise;
  final int index;
  final List<ExerciseModel> accommodateExercise;

  const ExerciseDone(
      {required this.duration,
      required this.exercise,
      required this.index,
      required this.accommodateExercise});
  @override
  List<Object> get props => [exercise, index, duration, accommodateExercise];
}

class TimerRunRest extends StartExerciseEvent {
  final Duration duration;
  final List<ExerciseModel> exercise;
  final int index;

  const TimerRunRest({
    required this.duration,
    required this.exercise,
    required this.index,
  });
  @override
  List<Object> get props => [exercise, index, duration];
}

class StopExercise extends StartExerciseEvent {
  final Duration duration;
  final int index;
  final List<ExerciseModel> exercises;
  const StopExercise(
      {required this.duration, required this.index, required this.exercises});

  @override
  List<Object> get props => [duration, index, exercises];
}

class IncrementRestDuration extends StartExerciseEvent {
  final Duration duration;
  final List<ExerciseModel> exercises;
  final int index;
  const IncrementRestDuration(
      {required this.duration, required this.exercises, required this.index});
  @override
  List<Object> get props => [duration, exercises, index];
}

class ResumeExercise extends StartExerciseEvent {
  final Duration duration;
  final int index;
  final List<ExerciseModel> exercises;
  const ResumeExercise(
      {required this.duration, required this.index, required this.exercises});

  @override
  List<Object> get props => [duration, index, exercises];
}

class SkipExercise extends StartExerciseEvent {
  final List<ExerciseModel> exercises;
  final int index;

  const SkipExercise({required this.exercises, required this.index});

  @override
  List<Object> get props => [exercises, index];
}

class NextExercise extends StartExerciseEvent {
  final List<ExerciseModel> exercises;
  final int index;

  const NextExercise({required this.exercises, required this.index});

  @override
  List<Object> get props => [exercises, index];
}

class PreviousExercise extends StartExerciseEvent {
  final List<ExerciseModel> exercises;
  final int index;

  const PreviousExercise({required this.exercises, required this.index});

  @override
  List<Object> get props => [exercises, index];
}
