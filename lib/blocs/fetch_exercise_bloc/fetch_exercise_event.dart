part of 'fetch_exercise_bloc.dart';

abstract class FetchExerciseEvent extends Equatable {
  const FetchExerciseEvent();

  @override
  List<Object> get props => [];
}

class LoadExercise extends FetchExerciseEvent {}

class UpdateExercise extends FetchExerciseEvent {
  final List<ExerciseModel> listExercise;
  const UpdateExercise(this.listExercise);

  @override
  List<Object> get props => [listExercise];
}
