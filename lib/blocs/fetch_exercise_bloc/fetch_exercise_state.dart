part of 'fetch_exercise_bloc.dart';

abstract class FetchExerciseState extends Equatable {
  const FetchExerciseState();

  @override
  List<Object> get props => [];
}

class ExerciseLoading extends FetchExerciseState {}

class ExerciseLoaded extends FetchExerciseState {
  final List<ExerciseModel> listExercise;
  const ExerciseLoaded(this.listExercise);
  @override
  List<Object> get props => [listExercise];
}

class ExerciseError extends FetchExerciseState {
  final String error;
  const ExerciseError(this.error);
  @override
  List<Object> get props => [error];
}
