// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_training_bloc.dart';

abstract class MyTrainingEvent extends Equatable {
  const MyTrainingEvent();

  @override
  List<Object> get props => [];
}

class MyTrainingStarted extends MyTrainingEvent {}

class NavigateToAddExercise extends MyTrainingEvent {}

class NavigatorPopToGet extends MyTrainingEvent {}

class AddToAcomodateExerciseEvent extends MyTrainingEvent {
  final ExerciseModel exerciseModel;
  const AddToAcomodateExerciseEvent({required this.exerciseModel});
  @override
  List<Object> get props => [exerciseModel];
}

class RemoveAccomodateExerciseEvent extends MyTrainingEvent {
  final ExerciseModel exerciseModel;
  const RemoveAccomodateExerciseEvent({required this.exerciseModel});
  @override
  List<Object> get props => [exerciseModel];
}

class SaveTraining extends MyTrainingEvent {
  final String name;
  final List<ExerciseModel> lExercises;
  const SaveTraining({required this.name, required this.lExercises});
  @override
  List<Object> get props => [name, lExercises];
}

class RemoveGetTraininng extends MyTrainingEvent {
  final TrainingModel tModel;
  const RemoveGetTraininng({required this.tModel});

  @override
  List<Object> get props => [tModel];
}

class ChangeTrainingName extends MyTrainingEvent {
  final String name;
  final TrainingModel tModel;
  const ChangeTrainingName({required this.name, required this.tModel});

  @override
  List<Object> get props => [name, tModel];
}
