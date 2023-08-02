part of 'my_training_bloc.dart';

abstract class MyTrainingState extends Equatable {
  const MyTrainingState();

  @override
  List<Object> get props => [];
}

class MyTrainingLoading extends MyTrainingState {}

class MyTrainigGet extends MyTrainingState {
  final List<TrainingModel> lTraining;
  const MyTrainigGet({
    required this.lTraining,
  });
  @override
  List<Object> get props => [lTraining];
}

class AddExerciseState extends MyTrainingState {
  final List<ExerciseModel> lAccomodateAdd;
  const AddExerciseState({required this.lAccomodateAdd});
  @override
  List<Object> get props => [lAccomodateAdd];
}
