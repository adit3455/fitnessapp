part of 'start_exercise_bloc.dart';

abstract class StartExerciseState extends Equatable {
  const StartExerciseState();

  @override
  List<Object?> get props => [];
}

class UnStartExercise extends StartExerciseState {}

class StartExerciseInitial extends StartExerciseState {
  final Duration duration;
  final int index;
  final List<ExerciseModel> exercises;

  const StartExerciseInitial(
      {this.duration = const Duration(seconds: 60),
      required this.index,
      required this.exercises});

  @override
  List<Object?> get props => [duration, index, exercises];
}

class PauseExercise extends StartExerciseState {
  final Duration duration;
  final int index;
  final List<ExerciseModel> exercises;

  const PauseExercise(
      {required this.duration, required this.index, required this.exercises});

  @override
  List<Object?> get props => [duration, index, exercises];
}

class RestExerciseState extends StartExerciseState {
  final Duration duration;
  final int index;
  final List<ExerciseModel> exercises;
  const RestExerciseState({
    required this.exercises,
    required this.duration,
    required this.index,
  });
  @override
  List<Object?> get props => [duration, exercises, index];
}

class NavigateExercise extends StartExerciseState {
  final List<ExerciseModel> exercise;
  final int index;
  const NavigateExercise({required this.exercise, required this.index});

  @override
  List<Object> get props => [exercise, index];
}

class DoneExerciseState extends StartExerciseState {
  final List<ExerciseModel> accomodateExercise;
  const DoneExerciseState({
    required this.accomodateExercise,
  });

  @override
  List<Object> get props => [accomodateExercise];
}
